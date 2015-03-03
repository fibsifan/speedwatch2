#!/bin/sh

speedtest() {
	# Performs a speedtest and stores the data in the database
}

setup() {
	# Sets up database configuration and checks for availability of
	# executables

	SPEEDTEST_CLI=$(which speedtest-cli)
	if [ ! -x $SPEEDTEST_CLI ] then
		>&2 echo "could not find speedtest-cli in your $PATH"
		exit 1;
	fi
}
