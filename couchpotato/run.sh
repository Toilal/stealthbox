#!/usr/bin/env sh

cat data/settings.conf>run.sh.tmp

echo -e "[core]">>run.sh.tmp
echo -e "password = $(jq -r "if .couchpotato.password then .couchpotato.password else .password end" ../conf/stealthbox.json | xargs echo -n | md5sum | awk '{print $1}')">>run.sh.tmp

echo -e "">>run.sh.tmp
echo -e "[deluge]">>run.sh.tmp
echo -e "password = $(jq -r "if .deluge.password then .deluge.password else .password end" ../conf/stealthbox.json | xargs echo -n)">>run.sh.tmp
cat run.sh.tmp | ../tools/ConfigParserPipe.py> data/settings.conf
rm run.sh.tmp

python install/CouchPotato.py --data_dir data --console_log
