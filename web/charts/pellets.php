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
	<style>
	canvas{
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
</head>

<body>


	<script>
		var t = prepare_data_arr();
		<?php
			$sql = "select year(`date`) as year, month(`date`) as month, sum(bags) as cnt
					from pellets
					group by year(`date`), month(`date`)
					order by year, month";
			$result = $conn->query($sql);
			while($row = $result->fetch_assoc()) {
				$m = $row["month"] - 1;
				echo "t[" . $row["year"] . "][" . $m  . "] = " . $row["cnt"] . ";";
			}
		?> 
		console.log(t);
	</script>

	<script>
		var labels = labels();
		var config = config('Pellets burn', t);

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		};

	</script>

	<div style="width:75%;">
		<canvas id="canvas"></canvas>
	</div>
	<br>
	<br>
	
</body>

</html>
