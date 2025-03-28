#!/bin/bash
chmod +x *.sh
. ./test.sh
# 1. Sort by response code
# 2. Unique IP
# 3. Requests with errors 4xx 5xx
# 4. Unique IPs found among the erroneous requests

rm -f report.html


if [[ $1 -eq 1 ]]; then
  additional="--sort-panel=STATUS_CODES,BY_DATA,ASC"
fi

if [[ $1 -eq 2 ]]; then
  additional="--sort-panel=VISITORS,BY_VISITORS,ASC"
fi

if [[ $1 -eq 3 ]]; then
  additional="--ignore-status=200 --ignore-status=201 --sort-panel=REQUESTS,BY_DATA,ASC"
fi

if [[ $1 -eq 4 ]]; then
  additional="--ignore-status=200 --ignore-status=201 --sort-panel=VISITORS,BY_VISITORS,ASC"
fi

sudo goaccess -p /etc/goaccess /home/robbicle/share/DO_4/04/log*.log "$additional" --date-format=%d/%b/%Y --log-format='%h %^ %^ [%d:%t %^] \"%r\" %s %b %^ %u' --time-format=%T -o /home/robbicle/share/DO_4/06/report4.html
