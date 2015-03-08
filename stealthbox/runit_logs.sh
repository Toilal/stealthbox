#!/bin/bash

# This adds a log/run file on each runit service directory.
# This file make services stdout/stderr output to svlogd log
# directory located in /var/log/runit/$service.

SERVICES=/etc/service/*

for f in $SERVICES
do
	service=$(basename "$f")
	if [ -d /etc/service/$service ]; then
		echo "Creating log/run for '$service'"
		mkdir -p /etc/service/$service/log
		cat > /etc/service/$service/log/run <<EOF;
#!/bin/bash

mkdir -p /home/box/logs
chmod o-wrx /home/box/logs
chown box:box /home/box/logs
mkdir -p /home/box/logs/$service
chmod o-wrx /home/box/logs/$service
chown box:box /home/box/logs/$service
exec setuser box svlogd -tt /home/box/logs/$service
EOF
		chmod +x /etc/service/$service/log/run
	fi
done