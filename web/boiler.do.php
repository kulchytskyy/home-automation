<?php include 'header.php';?>

<?php
  $action = $_POST['action'];
  $hour = $_POST['hour'];
  $min = $_POST['min'];
?>

<?php
	echo "action=$action<br/>";
	echo "hour=$hour<br/>";
	echo "min=$min<br/>";
?>

<?php
  $result = shell_exec("cd /home/pi/home-automation/ && ./scripts/schedule-emodul-cmd.sh $hour:$min $action 2>&1");
  echo "<br/>result:<br/>" . nl2br($result);
?>

<?php include 'footer.php';?>