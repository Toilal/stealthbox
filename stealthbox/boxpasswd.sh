#!/bin/bash
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [ ! "$(whoami)" == "box" ]; then
	echo "boxpasswd must run as 'box' user."
	exit 126;
fi;

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

# Store new password
if [ -f /home/box/.boxpasswd ]; then
	chmod 600 /home/box/.boxpasswd
fi
echo -n $PASSWORD>/home/box/.boxpasswd
chmod 400 /home/box/.boxpasswd

# Deluge
deluge_status=$(sv status deluge | cut -d ':' -f1)
deluge_web_status=$(sv status deluge-web | cut -d ':' -f1)
if [ "$deluge_status" == "run" ]; then sv -v -w 15 force-stop deluge; fi;
if [ "$deluge_web_status" == "run" ]; then sv -v -w 15 force-stop deluge-web; fi;

sed -ri "s/^(box:).*(:.*?)/\1$PASSWORD\2/" /home/box/deluge/auth

deluge=$($DIR/passwd/passwd.deluge.py $PASSWORD)
deluge_sha1=$(echo $deluge | cut -d ':' -f 1)
deluge_salt=$(echo $deluge | cut -d ':' -f 2)

sed -ri "s/(\"pwd_sha1\":).*?(,)/\1 \"$deluge_sha1\"\2/" /home/box/deluge/web.conf
sed -ri "s/(\"pwd_salt\":).*?(,)/\1 \"$deluge_salt\"\2/" /home/box/deluge/web.conf

if [ "$deluge_status" == "run" ]; then sv start deluge; fi;
if [ "$deluge_web_status" == "run" ]; then sv start deluge-web; fi;

# CouchPotato
couchpotato_status=$(sv status couchpotato | cut -d ':' -f1)
if [ "$couchpotato_status" == "run" ]; then sv -v -w 15 force-stop couchpotato; fi;

couchpotato_md5=$(echo -n $PASSWORD| md5sum | cut -d ' ' -f 1)
{ cat /home/box/couchpotato/settings.conf; echo -e "\n[core]\npassword = $couchpotato_md5\n\n[deluge]\npassword = $PASSWORD\n"; } | $DIR/tools/ConfigParserPipe.py> /home/box/couchpotato/settings.conf

if [ "$couchpotato_status" == "run" ]; then sv start couchpotato; fi;

# SickRage
sickrage_status=$(sv status sickrage | cut -d ':' -f1)
if [ "$sickrage_status" == "run" ]; then sv -v -w 15 force-stop sickrage; fi;

{ cat /home/box/sickrage/config.ini; echo -e "\n[General]\nweb_password = $PASSWORD\n\n[TORRENT]\ntorrent_password = $PASSWORD\n"; } | $DIR/tools/ConfigParserPipe.py> /home/box/sickrage/config.ini

if [ "$sickrage_status" == "run" ]; then sv start sickrage; fi;

# HeadPhones
headphones_status=$(sv status headphones | cut -d ':' -f1)
if [ "$headphones_status" == "run" ]; then sv -v -w 15 force-stop headphones; fi;

{ cat /home/box/headphones/config.ini; echo -e "\n[General]\nhttp_password = $PASSWORD\n"; } | $DIR/tools/ConfigParserPipe.py> /home/box/headphones/config.ini

if [ "$headphones_status" == "run" ]; then sv start headphones; fi;

# Pydio
pydio_hash=$(php -f $DIR/passwd/passwd.pydio.php "password=$PASSWORD")
sqlite3 /home/box/pydio/plugins/conf.sql/pydio.db "UPDATE ajxp_users SET password='$pydio_hash' WHERE login='box'"

echo "Password changed!"