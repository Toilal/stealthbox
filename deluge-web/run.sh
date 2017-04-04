#!/usr/bin/env sh

set -e

STEALTHBOX_CONF="../conf/stealthbox.json"
if [ -f $STEALTHBOX_CONF ]; then
    ./update.web.password.py $(jq -r 'if .["deluge-web"].password then .["deluge-web"].password else .password end' $STEALTHBOX_CONF | xargs echo -n)
    ./update.host.password.py $(jq -r 'if .deluged.password then .deluged.password else .password end' $STEALTHBOX_CONF | xargs echo -n)
else
    echo "$(basename $STEALTHBOX_CONF) not found. Using default configuration ..."
fi

cd /home/box/deluge-web/data
deluge-web -c config -L info