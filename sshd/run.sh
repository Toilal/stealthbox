#!/usr/bin/env sh

# SSHD
password=$(jq -r "if .sshd.password then .sshd.password else .password end" /home/box/conf/stealthbox.json | xargs echo -n | awk '{print $1}')

echo "root:$password" | chpasswd
echo "box:$password" | chpasswd

/sshd
