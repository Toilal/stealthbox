#!/bin/bash

# if config file doesnt exist (wont exist until user changes a setting) then copy default config file
if [[ ! -f /config/core.conf ]]; then
	echo "[info] Deluge config file doesn't exist, copying default..."
	cp /home/nobody/deluge/core.conf /config/
else
	echo "[info] Deluge config file already exists, skipping copy"
fi

echo "[info] Starting Deluge daemon..."
/usr/bin/deluged -d -c /config -L info -l /config/deluged.log