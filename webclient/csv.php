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
$query = mysql_query($myquery) or die ("Sql error: " . mysql_error());

$fields = mysql_num_fields ($query);

//for ($i = 0; $i < $fields; $i++ ) {
//	$header .= '"' . mysql_field_name($query, $i) . '"' . "\t";
//}
$header = '"time", "download", "upload", "ping"';

while( $row = mysql_fetch_row($query) ) {
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

mysql_close($server);

?>
