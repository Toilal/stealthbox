#!/usr/bin/env sh

cat data/config.ini>run.sh.tmp

echo -e "[General]">>run.sh.tmp
echo -e "http_password = $(jq -r "if .headphones.password then .headphones.password else .password end" ../conf/stealthbox.json | xargs echo -n | awk '{print $1}')">>run.sh.tmp

if [ -z "${VIRTUAL_HOST+x}" ]; then
    echo -e "http_root = /headphones">>run.sh.tmp
fi

echo -e "">>run.sh.tmp
echo -e "[Deluge]">>run.sh.tmp
echo -e "deluge_password = $(jq -r "if .deluge.password then .deluge.password else .password end" ../conf/stealthbox.json | xargs echo -n)">>run.sh.tmp
cat run.sh.tmp | ../tools/ConfigParserPipe.py> data/config.ini
rm run.sh.tmp

python install/Headphones.py -p 8181 --datadir data --nolaunch
