#!/bin/bash

chmod 770 /etc/service/flexget-when-changed/supervise
chown box:box -R /etc/service/flexget-when-changed/supervise

cd /home/box/flexget
exec setuser box when-changed *.yml -c "flexget daemon reload"