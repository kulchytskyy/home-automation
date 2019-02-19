<?php
$servername = "localhost";
$username = "t";
$password = "t123456";
$dbname = "t";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}
?> 

<!doctype html>
<html>

<head>
	<title>Line Chart</title>
	<script src="js/Chart.bundle.js"></script>
	<script src="data/temperature.js"></script>
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
					if ( $row["id"] == $_GET["sensor_id"]){
						echo " selected ";
					}
					echo ">";
					echo $row["name"];
					echo "</option>";
				}
			?> 
		</select>
	</form>

	<script>
		var temperatures = {};
		for (y = 2017; y<=2019; y++){
			temperatures[y]=[];
		}
		<?php
			$sql = "select year(`date`) as year, month(`date`) as month, avg(temperature) as temp
					from temperatures
					where sensor_id=" . $_GET["sensor_id"] . "
					group by year(`date`), month(`date`)
					order by year, month";
			$result = $conn->query($sql);
			while($row = $result->fetch_assoc()) {
				echo "temperatures[" . $row["year"] . "][" . $row["month"] . "-1] = " . $row["temp"] . ";";
			}
		?> 
		console.log(temperatures);
	</script>

	<script>
		var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		var config = {
			type: 'line',
			data: {
				labels: MONTHS,
				datasets: [{
					label: '2017',
					backgroundColor: '#FF0000',
					borderColor: '#FF0000',
					data: temperatures[2017],
					fill: false,
				}, {
					label: '2018',
					fill: false,
					backgroundColor: '#0000FF',
					borderColor: '#0000FF',
					data: temperatures[2018],
					fill: false,
				}, {
					label: '2019',
					fill: false,
					backgroundColor: '#00FFFF',
					borderColor: '#00FFFF',
					data: temperatures[2019],
					fill: false,
				}]
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: 'Temperature by months'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}]
				}
			}
		};

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
