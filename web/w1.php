<html>
<body>

<?php

$o = &shell_exec("cat /sys/bus/w1/devices/*/w1_slave");
echo "<pre>$o</pre>";

?>

</body>
</html>