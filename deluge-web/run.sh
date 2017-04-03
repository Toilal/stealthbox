#!/usr/bin/env sh

cd /home/box/deluge-web/data

#TODO: Update deluged password in hostlist.conf.1.2 and deluge-web password in web.conf (see passwd.deluge.py)
deluge-web -c config -L info