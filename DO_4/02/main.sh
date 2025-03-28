#!/bin/bash


chmod +x *.sh
. ./test.sh
. ./file_trash.sh

Start_time=$(date +%s)
timeRunIn=`date +%H:%M:%S`

if [[ -f log.txt ]]; then
rm -f log.txt
fi
if [[ -f log_trash.txt ]]; then
rm -f log_trash.txt
fi

check $1 $2 $3
StartGen
time_script
