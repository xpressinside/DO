#!/bin/bash
. ./test.sh
. ./clean.sh

check $1
echo -e "before -> `df -h /`\n"
if [[ $mode = 1 ]]; then
    LogFileClearing
elif [[ $mode = 2 ]]; then
    DateTimeClearing
elif [[ $mode = 3 ]]; then
    NameMaskClearing $2
fi

echo "after -> `df -h /`"