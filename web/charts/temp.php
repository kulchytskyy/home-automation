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
		group by :
		<select name="group_by" onchange="this.form.submit()">
			<option value="MONTH" <?php if ( $_GET["group_by"] == 'MONTH') { echo "selected"; } ?> >month</option>
			<option value="DAYOFYEAR" <?php if ( $_GET["group_by"] == 'DAYOFYEAR') { echo "selected"; } ?>>day of year</option>
		</select>
	</form>

	<script>
		var t = {};
		for (y = 2017; y<=2019; y++){
			t[y]=[];
		}
		<?php
			$sql = "select year(`date`) as year, " . $_GET["group_by"] . "(`date`) as month, avg(temperature) as temp
					from temperatures
					where sensor_id=" . $_GET["sensor_id"] . "
					group by year(`date`), " . $_GET["group_by"] . "(`date`)
					order by year, month";
			$result = $conn->query($sql);
			while($row = $result->fetch_assoc()) {
				echo "t[" . $row["year"] . "][" . $row["month"] . "-1] = " . $row["temp"] . ";";
			}
		?> 
		console.log(t);
	</script>

	<script>
		<?php
		if ( $_GET["group_by"] == 'MONTH'){
		?>
				var labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
		<?php
		}
		else{
		?>
			var labels = [];
			for (var i=1; i<365; i++){
				labels.push(i);
			}
		<?php
		}
		?>
		var config = {
			type: 'line',
			data: {
				labels: labels,
				datasets: [{
					label: '2017',
					backgroundColor: '#FF0000',
					borderColor: '#FF0000',
					data: t[2017],
					fill: false,
				}, {
					label: '2018',
					fill: false,
					backgroundColor: '#0000FF',
					borderColor: '#0000FF',
					data: t[2018],
					fill: false,
				}, {
					label: '2019',
					fill: false,
					backgroundColor: '#00FFFF',
					borderColor: '#00FFFF',
					data: t[2019],
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
