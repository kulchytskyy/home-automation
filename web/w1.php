<?php include 'header.php';?>

<?php

$o = &shell_exec("cat /sys/bus/w1/devices/*/w1_slave");
echo "<pre>$o</pre>";

?>

<?php include 'footer.php';?>
