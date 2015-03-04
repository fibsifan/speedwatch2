<?php
$username = "speedwatch";
$password = "speedwatch";
$host = "localhost";
$database="speedwatch";

$server = mysql_connect($host, $username, $password);
$connection = mysql_select_db($database, $server);

$mindate=$_GET["mindate"];
if ( ! $mindate ) {
	$mindate = "'0000-00-00 00:00:00'";
}
$maxdate=$_GET["maxdate"];
if ( ! $maxdate ) {
	$maxdate = "NOW()";
}

$myquery = "SELECT TIMESTAMP, DOWNLOAD, UPLOAD, PING FROM `SPEEDWATCH2` WHERE TIMESTAMP BETWEEN ".$mindate." AND ".$maxdate.";";
$query = mysql_query($myquery);

if ( ! $query ) {
	echo mysql_error();
	die;
}

$data = array();

for ($x = 0; $x < mysql_num_rows($query); $x++) {
	$data[] = mysql_fetch_assoc($query);
}

echo json_encode($data);

mysql_close($server);
?>
