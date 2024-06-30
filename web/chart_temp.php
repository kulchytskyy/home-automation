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

if (isset($_GET["group_by"])){
	$group_by = $_GET["group_by"];
}
else{
	$group_by = 'MONTH';
}

if (isset($_GET["sensor_id"])){
	$sensor_id = $_GET["sensor_id"];
}
else{
	$sensor_id = 9;
}
if (isset($_GET["chart_type"])){
	$chart_type = $_GET["chart_type"];
}
else{
	$chart_type = 'line';
}


function dayofyear2date( $tDay, $tFormat = 'j M' ) {
    $day = intval( $tDay );
    $day = ( $day == 0 ) ? $day : $day - 1;
    $offset = intval( intval( $tDay ) * 86400 );
    $str = date( $tFormat, strtotime( 'Jan 1, ' . date( 'Y' ) ) + $offset );
    return( $str );
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


	<form action="#">
		sensor:
		<select name="sensor_id" onchange="this.form.submit()">
			<?php
				$sql = "SELECT * FROM sensors ORDER BY channel_id, field_num";
				$result = $conn->query($sql);
				while($row = $result->fetch_assoc()) {
					echo "<option value='" . $row["id"] . "'";
					if ( $row["id"] == $sensor_id){
						echo " selected ";
					}
					echo ">";
					echo $row["name"];
					echo "</option>";
				}
			?> 
		</select>
		group by :
		<select name="group_by" onchange="this.form.submit()">
			<option value="MONTH" <?php if ( $group_by == 'MONTH') { echo "selected"; } ?> >month</option>
			<option value="DAYOFYEAR" <?php if ( $group_by == 'DAYOFYEAR') { echo "selected"; } ?>>day of year</option>
		</select>
		chart type :
		<select name="chart_type" onchange="this.form.submit()">
			<option value="line" <?php if ( $chart_type == 'line') { echo "selected"; } ?> >line</option>
			<option value="bar" <?php if ( $chart_type == 'bar') { echo "selected"; } ?>>bar</option>
		</select>
	</form>

	<script>
		var t = prepare_data_arr();
		console.log(t);
		<?php
			$sql = "select year(`date`) as year, " . $group_by . "(`date`) as month, avg(temperature) as temp
					from daily_average
					where sensor_id=" . $sensor_id . "
					group by year(`date`), " . $group_by . "(`date`)
					order by year, month";
			$result = $conn->query($sql);
			while($row = $result->fetch_assoc()) {
				$m = $row["month"] - 1;
				echo "t[" . $row["year"] . "][" . $m  . "] = " . $row["temp"] . ";";
			}
		?> 
		console.log(t);
	</script>

	<script>
		<?php
		if ( $group_by == 'MONTH'){
		?>
				var labels = labels();
		<?php
		}
		else{
		?>
			<?php
				echo "var labels = [];";
				for ($i = 0; $i < 365; $i++) {
					echo "labels.push(";
					echo "'" . dayofyear2date($i) . "'";
					echo ");";
				}
			?>
		<?php
		}
		?>
		var chart_type = '<?php echo $chart_type ?>';
                var config = config('Pellets burn', t, chart_type);

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
