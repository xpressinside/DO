#!/bin/bash

if [[ -f creation.log ]]; then
rm -f creation.log
fi
chmod +x *.sh

. ./function.sh
. ./checks.sh

sudo bash -c "touch creation.log"
check $1 $2 $3 $4 $5 $6
start

if [ $(dpkg-query -W -f='${Status}' nano 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo bash -c "apt install tree -y"
else
  tree $1 --du --si --dirsfirst 2>/dev/null
fi