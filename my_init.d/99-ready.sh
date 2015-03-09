#!/bin/bash
set -e

password=$(cat /home/box/.boxpasswd)

echo "StealthBox is ready!"
echo -e
echo "Username: box"
echo "Password: $password"
echo -e
echo "You can change the password using 'boxpasswd' command from shell"
echo -e