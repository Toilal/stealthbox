#!/bin/bash

chmod 770 /etc/service/flexget/supervise
chown box:box -R /etc/service/flexget/supervise

cd /home/box/flexget
exec setuser box flexget daemon start >/dev/null