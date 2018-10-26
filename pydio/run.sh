#!/usr/bin/env sh

# TODO: Move this in pydio-db container
# Pydio
password=$(jq -r 'if .pydio.password then .pydio.password else .password end' /home/box/conf/stealthbox.json | xargs echo -n | awk '{print $1}')

# Password change doesn't work with pydio 8, sources have changed.
#pydio_hash=$(curl -f -s --get --data-urlencode "password=$password" http://nginx-php/scripts/passwd.pydio.php)
#sqlite3 /opt/pydio/data/plugins/conf.sql/pydio.db "UPDATE ajxp_users SET password='$pydio_hash' WHERE login='box'"
