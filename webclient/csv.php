<?php
$username = "speedwatch";
$password = "speedwatch";
$host = "localhost";
$database="speedwatch";

$mysqli = new mysqli($host, $username, $password, $database);
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_error;
}

$mindate=$_GET["mindate"];
if ( ! $mindate ) {
	$mindate = "'0000-00-00 00:00:00'";
}
$maxdate=$_GET["maxdate"];
if ( ! $maxdate ) {
	$maxdate = "NOW()";
}

$myquery = "SELECT TIMESTAMP, DOWNLOAD, UPLOAD, PING FROM `SPEEDWATCH2` WHERE TIMESTAMP BETWEEN ".$mindate." AND ".$maxdate.";";
$res = $mysqli->query($myquery);

$fields = $res->field_count;

//for ($i = 0; $i < $fields; $i++ ) {
//	$header .= '"' . mysql_field_name($query, $i) . '"' . "\t";
//}
$header = '"time", "download", "upload", "ping"';

while( $row = $res->fetch_row() ) {
	$line = '';
	foreach( $row as $value ) {
		if (( !isset ($value)) || ($value == "")) {
			$value = ", ";
		} else {
			$value = str_replace('"', '""', $value);
			$value = '"' . $value . '"' . "\t";
		}
		$line .= $value;
	}
	$data .= trim($line) . "\n";
}

if ($data == "") {
	$data = "\n(0) Records Found!\n";
}

header("Content-type: text/csv");
header("Content-Disposition: attachment; filename=speedwatch2.csv");
header("Pragma: no-cache");
header("Expires: 0");
$data = $header . "\n" . $data;
$data = str_replace ("\t", ", ", $data);
echo $data;

$mysqli->close();
?>
