<?php
$username = "speedwatch";
$password = "speedwatch";
$host = "localhost";
$database="speedwatch";

$mysqli = new mysqli($host, $username, $password, $database);
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_error;
}

$maxdate=$_GET["maxdate"];
if ( ! $maxdate ) {
	$maxdate = "NOW()";
} else {
    $maxdate="STR_TO_DATE('".$maxdate."', '%Y-%m-%d')";
}

$mindate=$_GET["mindate"];
if ( ! $mindate ) {
	$mindate = $maxdate." - INTERVAL 3 DAY";
} else {
    $mindate="STR_TO_DATE('".$mindate."', '%Y-%m-%d')";
}

$myquery = "SELECT TIMESTAMP, DOWNLOAD, UPLOAD, PING FROM `SPEEDWATCH2` WHERE TIMESTAMP BETWEEN ".$mindate." AND ".$maxdate.";";
$res = $mysqli->query($myquery);

if ( ! $res ) {
	echo $mysqli->error();
	die;
}

$data = array();

while ($row = $res->fetch_assoc()) {
	$data[] = $row;
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
$mysqli->close();
?>
