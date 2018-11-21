<!DOCTYPE html>
<html>
<head>
</head>
<body>


<?php
//$cron = &shell_exec("crontab -l | grep -v \"#\"");
$cron = &shell_exec("at -l");
echo "<p>cron:<br/>" . nl2br($cron);

?>
	<form action="boiler.do.php" method="POST">
		<select name="action">
			<option value="stop" selected="">stop</option>
			<option value="start">start</option>
		</select>
		<select name="hour">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
		</select>
		:
		<select name="min">
			<option value="00">00</option>
			<option value="15">15</option>
			<option value="30">30</option>
			<option value="45">45</option>
		</select>
		<input type="submit" name="schedule" value="Schedule">
	</form>
</body>
</html>
