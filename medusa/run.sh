#!/usr/bin/env sh

cat data/config.ini>run.sh.tmp

echo -e "[General]">>run.sh.tmp
echo -e "web_password = $(jq -r 'if .medusa.password then .medusa.password else .password end' ../conf/stealthbox.json | xargs echo -n | awk '{print $1}')">>run.sh.tmp

if [ -z "${VIRTUAL_HOST+x}" ]; then
    echo -e "web_root = /medusa">>run.sh.tmp
fi

echo -e "">>run.sh.tmp
echo -e "[TORRENT]">>run.sh.tmp
echo -e "torrent_password = $(jq -r 'if .["deluge-web"].password then .["deluge-web"].password else .password end' ../conf/stealthbox.json | xargs echo -n)">>run.sh.tmp

cat run.sh.tmp | ../tools/ConfigParserPipe.py> data/config.ini
rm run.sh.tmp

python /home/box/medusa/install/SickBeard.py --datadir=/home/box/medusa/data --nolaunch
