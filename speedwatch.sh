#!/bin/sh

# Edit this to your needs:
MYSQL_USER=speedwatch
MYSQL_PASS=speedwatch
MYSQL_DB=speedwatch

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

# The Speed test:
$SPEEDTEST_CLI --simple > /tmp/speedwatch2.tmp
PING=$(grep Ping /tmp/speedwatch2.tmp | sed s/'^Ping: \(.*\) ms$'/'\1'/)
DOWNLOAD=$(grep Download /tmp/speedwatch2.tmp | sed s/'^Download: \(.*\) Mbit\/s$'/'\1'/)
UPLOAD=$(grep Upload /tmp/speedwatch2.tmp | sed s/'^Upload: \(.*\) Mbit\/s$'/'\1'/)
rm /tmp/speedwatch2.tmp

# Build SQL file
cat << "EOF" > /tmp/speedwatch2.sql
CREATE TABLE IF NOT EXISTS `SPEEDWATCH2` (
	`ID` int unsigned NOT NULL auto_increment,
	`TIMESTAMP` timestamp NOT NULL,
	`DOWNLOAD` decimal(6,2) default 0,
	`UPLOAD` decimal(6,2) default 0,
	`PING` decimal(8,3) unsigned default 0,
	PRIMARY KEY (`ID`)
	);
EOF

echo "INSERT INTO SPEEDWATCH2 (DOWNLOAD, UPLOAD, PING)" >> /tmp/speedwatch2.sql
echo "VALUES ($DOWNLOAD, $UPLOAD, $PING);" >> /tmp/speedwatch2.sql
# Insert into mysql
$MYSQL_CLI --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQL_DB < /tmp/speedwatch2.sql
rm /tmp/speedwatch2.sql

