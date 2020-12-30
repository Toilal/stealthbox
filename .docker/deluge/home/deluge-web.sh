#!/bin/bash

# wait for deluge daemon process to start (listen for port)
while [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".58846"') == "" ]]; do
    sleep 0.1
done

# if config file doesnt exist then copy stock config file
if [[ ! -f /config/web.conf ]]; then
    echo "[info] Deluge webui config file doesn't exist, copying default..."
    cp /home/nobody/webui/web.conf /config/
fi

if [[ -n "$DELUGE_SHA1" ]] && [[ -n "$DELUGE_SALT" ]]; then
    echo "[password] Setting password from DELUGE_SHA1 and DELUGE_SALT environment variables"
    /home/nobody/passwd.py /config/web.conf --salt "$DELUGE_SALT" --sha1 "$DELUGE_SHA1"
else
    if [[ -n "$DELUGE_PASSWORD" ]]; then
        echo "[password] Setting password from DELUGE_PASSWORD environment variables"
        /home/nobody/passwd.py /config/web.conf --password "$DELUGE_PASSWORD"
    fi
fi

echo "[info] Starting Deluge webui..."
/usr/bin/deluge-web -c /config
