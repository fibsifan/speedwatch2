CREATE TABLE IF NOT EXISTS `SPEEDWATCH2` (
	`ID` int unsigned NOT NULL auto_increment,
	`TIMESTAMP` timestamp NOT NULL,
	`DOWNLOAD` decimal(6,2) default 0,
	`UPLOAD` decimal(6,2) default 0,
	`PING` decimal(8,3) unsigned default 0,
	PRIMARY KEY (`ID`)
	)
