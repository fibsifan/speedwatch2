#!/bin/sh

if [ $UID -eq 0 ]; then
	CONFIG_PATH=/etc/
else
	CONFIG_PATH=$HOME/.config/
fi

SPEEDTEST_CLI=$(which speedtest-cli)
if [ ! -x $SPEEDTEST_CLI ]; then
	>&2 echo 'could not find speedtest-cli in your $PATH'
	exit 1
fi

MYSQL_CLI=$(which mysql)
if [ ! -x $MYSQL_CLI ]; then
	>&2 echo 'could not find mysql in your $PATH'
	exit 1
fi

# check if config file exists
if [ -f $CONFIG_PATH/speedwatch2.sh ]; then
	. $CONFIG_PATH/speedwatch2.sh
	$MYSQL_CLI --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQL_DB < speedwatch.sql
else
	echo 'Config file was missing, creating one in $CONFIG_PATH/speedwatch2.sh'
	echo "Edit it to your needs and run this again."
	echo "MYSQL_USER=speedwatch" >> $CONFIG_PATH/speedwatch2.sh
	echo "MYSQL_PASS=speedwatch" >> $CONFIG_PATH/speedwatch2.sh
	echo "MYSQL_DB=speedwatch" >> $CONFIG_PATH/speedwatch2.sh
	exit 1
fi

$SPEEDWATCH_CLI --simple > /tmp/speedwatch2.tmp
PING=grep Ping: /tmp/speedwatch2.tmp | sed s/'^Ping: \(.*\) ms$'/'\1'/
DOWNLOAD=grep Download: /tmp/speedwatch2.tmp | sed s/'^Download: \(.*\) Mbits\/s$'/'\1'/
UPLOAD=grep Upload: /tmp/speedwatch2.tmp | sed s/'^Upload: \(.*\) Mbits\/s$'/'\1'/
rm /tmp/speedwatch2.tmp

# Build SQL file
echo "INSERT INTO SPEEDWATCH2 (DOWNLOAD, UPLOAD, PING)" > /tmp/speedwatch2.sql
echo "VALUES ($DOWNLOAD, $UPLOAD, $PING);"
# Insert into mysql
$MYSQL_CLI --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQ_DB < /tmp/speedwatch2.sql
rm /tmp/speedwatch2.sql
