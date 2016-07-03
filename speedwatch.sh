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
SPEEDTEST_TMP=$(tmpfile)
$SPEEDTEST_CLI --simple > ${SPEEDTEST_TMP}
PING=$(grep Ping ${SPEEDTEST_TMP} | sed s/'^Ping: \(.*\) ms$'/'\1'/)
DOWNLOAD=$(grep Download ${SPEEDTEST_TMP} | sed s/'^Download: \(.*\) Mbit\/s$'/'\1'/)
UPLOAD=$(grep Upload ${SPEEDTEST_TMP} | sed s/'^Upload: \(.*\) Mbit\/s$'/'\1'/)
rm ${SPEEDTEST_TMP}

# Build SQL file
SPEEDTEST_SQL=$(tmpfile)
cat << "EOF" > ${SPEEDTEST_SQL}
CREATE TABLE IF NOT EXISTS `SPEEDWATCH2` (
	`ID` int unsigned NOT NULL auto_increment,
	`TIMESTAMP` timestamp NOT NULL,
	`DOWNLOAD` decimal(6,2) default 0,
	`UPLOAD` decimal(6,2) default 0,
	`PING` decimal(8,3) unsigned default 0,
	PRIMARY KEY (`ID`)
	);
EOF

echo "INSERT INTO SPEEDWATCH2 (DOWNLOAD, UPLOAD, PING)" >> ${SPEEDTEST_SQL}
echo "VALUES ($DOWNLOAD, $UPLOAD, $PING);" >> ${SPEEDTEST_SQL}
# Insert into mysql
$MYSQL_CLI --user=$MYSQL_USER --password=$MYSQL_PASS $MYSQL_DB < ${SPEEDTEST_SQL}
rm ${SPEEDTEST_SQL}

