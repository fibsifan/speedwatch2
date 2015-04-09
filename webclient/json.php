<?php
$username = "speedwatch";
$password = "speedwatch";
$host = "localhost";
$database="speedwatch";

$server = mysql_connect($host, $username, $password);
$connection = mysql_select_db($database, $server);

$mindate=$_GET["mindate"];
if ( ! $mindate ) {
	$mindate = "NOW() - INTERVAL 4 DAY";
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

header("Content-Type: application/json");
header("Pragma: no-cache");
header("Expires: 0");
$data = json_encode($data);

$data = str_replace('"TIMESTAMP"', '"timestamp"', $data);
$data = str_replace('"DOWNLOAD"', '"download"', $data);
$data = str_replace('"UPLOAD"', '"upload"', $data);
$data = str_replace('"PING"', '"ping"', $data);

echo $data;
mysql_close($server);
?>
