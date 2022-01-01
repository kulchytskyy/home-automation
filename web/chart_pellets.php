<?php include 'header.php';?>
<?php

//$config = parse_ini_file(__DIR__ . '/../../../ha_config.ini', true); 
$config = parse_ini_file('/var/www/ha_config.ini', true); 


$servername = $config['database']['host'];
$username = $config['database']['user'];
$password = $config['database']['password'];
$dbname = $config['database']['database'];

$conn = new mysqli($servername, $username, $password, $dbname);
//$conn = new mysqli('localhost', 'ha', 'mysql123', 'ha');
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}

?> 

<!doctype html>
<html>

<head>
	<title>Line Chart</title>
	<script src="js/Chart.bundle.js"></script>
	<script src="js/func.js"></script>
</head>

<body>


	<script>
 		var t = prepare_data_arr();
		<?php
			$sql = "
				select 	 
					case when month(`date`)>=10 then month(`date`)-10 else month(`date`)+2 end as m,
					case when month(`date`)>=10 then year(`date`) else year(`date`)-1 end as y,
					sum(bags) as cnt
				from pellets
				group by 
					case when month(`date`)>=10 then month(`date`)-10 else month(`date`)+2 end,
					case when month(`date`)>=10 then year(`date`) else year(`date`)-1 end
				order by y, m
			";
			$result = $conn->query($sql);
			while($row = $result->fetch_assoc()) {
				$m = $row["m"];
				echo "t[" . $row["y"] . "][" . $m  . "] = " . $row["cnt"] . ";\n";
			}
		?> 
		console.log(t);
	</script>

	<script>
                function labels(){
                        return ['October', 'November', 'December','January', 'February', 'March', 'April'];
                }

		var labels = labels();
		var config = config('Pellets burn', t);

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		};

	</script>

	<div>
		<canvas id="canvas"></canvas>
	</div>
	<br>
	<br>
	
</body>

</html>
<?php include 'footer.php';?>
