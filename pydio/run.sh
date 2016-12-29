#!/usr/bin/env sh

# Pydio
password=$(jq -r "if .pydio.password then .pydio.password else .password end" /home/box/conf/stealthbox.json | xargs echo -n | awk '{print $1}')
pydio_hash=$(curl -s --retry 9999 --retry-delay 2 --get --data-urlencode "password=$password" http://nginx/scripts/passwd.pydio.php)
sqlite3 /opt/pydio/data/plugins/conf.sql/pydio.db "UPDATE ajxp_users SET password='$pydio_hash' WHERE login='box'"
