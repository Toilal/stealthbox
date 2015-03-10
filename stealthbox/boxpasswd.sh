#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ -z "$1" ]; then
	echo -n "New password: "
	read -s PASSWORD
	echo -e
	echo -n "New password (confirm): "
	read -s PASSWORD2
	echo -e

	if [ "$PASSWORD" != "$PASSWORD2" ]; then
		echo "Passwords doesn't match"
		exit 1
	fi
else
	PASSWORD=$1
fi

CHECK="$(cracklib-check <<<"$PASSWORD")"
if [[ $CHECK != *"OK" ]]; then
	echo "Password check fail!"
	echo $CHECK
	exit 2
fi
echo "Changing password..."

if [ -f /home/box/.boxpasswd ]; then
	OLD_PASSWORD=$(cat /home/box/.boxpasswd)
	$DIR/passwd/autopasswd.sh "$OLD_PASSWORD" "$PASSWORD"
else
	$DIR/passwd/autopasswd.sh "box12345" "$PASSWORD"
fi

# Deluge

sed -ri "s/^(box:).*(:.*?)/\1$PASSWORD\2/" /home/box/deluge/auth

deluge=$($DIR/passwd/passwd.deluge.py $PASSWORD)
deluge_sha1=$(echo $deluge | cut -d ':' -f 1)
deluge_salt=$(echo $deluge | cut -d ':' -f 2)

sed -ri "s/(\"pwd_sha1\":).*?(,)/\1 \"$deluge_sha1\"\2/" /home/box/deluge/web.conf
sed -ri "s/(\"pwd_salt\":).*?(,)/\1 \"$deluge_salt\"\2/" /home/box/deluge/web.conf

# CouchPotato
couchpotato_md5=$(echo -n $PASSWORD| md5sum | cut -d ' ' -f 1)
sed -ri "s/^(password\s*=\s*).*/\1$couchpotato_md5/" /home/box/couchpotato/settings.conf

# SickRage
sed -ri "s/^(web_password\s*=\s*).*/\1$PASSWORD/" /home/box/sickrage/config.ini
sed -ri "s/^(torrent_password\s*=\s*).*/\1$PASSWORD/" /home/box/sickrage/config.ini

# HeadPhones
sed -ri "s/^(http_password\s*=\s*).*/\1$PASSWORD/" /home/box/headphones/config.ini

# Pydio
pydio_hash=$(php -f $DIR/passwd/passwd.pydio.php "password=$PASSWORD")
sqlite3 /home/box/pydio/plugins/conf.sql/pydio.db "UPDATE ajxp_users SET password='$pydio_hash' WHERE login='box'"

# Store new password
if [ -f /home/box/.boxpasswd ]; then
	chmod 600 /home/box/.boxpasswd
fi
echo -n $PASSWORD>/home/box/.boxpasswd
chmod 400 /home/box/.boxpasswd

echo "Password changed!"