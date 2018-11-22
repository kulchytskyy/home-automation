<?php include 'header.php';?>

<?php

$path = '/home/pi/home-automation/temperature/w1/get.sh';

$t1 = &shell_exec("$path 28-0316811ffaff");
echo "<p>t1=$t1";

$t2 = &shell_exec("$path 28-03168123a0ff");
echo "<p>t2=$t2";

$t3 = &shell_exec("$path 28-0416812edaff");
echo "<p>t3=$t3";

$t4 = &shell_exec("$path 28-0516848757ff");
echo "<p>t4=$t4";

$path2 = '/home/pi/home-automation/temperature/ea2/get.sh';

$t5 = &shell_exec("$path2 1");
echo "<p>living=$t5";

$t6 = &shell_exec("$path2 2");
echo "<p>bathroom=$t6";

$t7 = &shell_exec("$path2 3");
echo "<p>outdoor=$t7";
?>

<?php include 'footer.php';?>
