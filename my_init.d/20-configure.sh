#!/bin/bash
set -e

if [ ! -t 0 ]; then
	echo 'Shell is NON interactive.'
	export NONINTERACTIVE=1
else
	echo 'Shell is interactive.'
fi

if [ -f /home/box/.boxpasswd ]; then
	# Ensure to set the system password like password file
	# Useful when running a new container with an existing volume
	OLD_PASSWORD=$(cat /home/box/.boxpasswd)
	echo "box:$OLD_PASSWORD" | chpasswd
fi

if [ ! -z "$PASSWORD" ]; then
	echo "Set password using PASSWORD environment variable."
	setuser box boxpasswd $PASSWORD
else
	if [ ! -f /home/box/.boxpasswd ]; then
		echo "No existing password found. Creating one."
		if [ -z "$NONINTERACTIVE" ]; then
			setuser box boxpasswd
		else
			echo "Generating a password with pwgen."
			PASSWORD=$(pwgen -1cnB 10)
			setuser box boxpasswd $PASSWORD
		fi
	fi
fi



