#!/usr/bin/env sh

cd /home/box/deluged/data

password=$(jq -r 'if .deluged.password then .deluged.password else .password end' ../../conf/stealthbox.json | xargs echo -n)
echo -e "box:$password:10\n">config/auth

deluged -d -c config -L info