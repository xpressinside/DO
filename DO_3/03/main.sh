#!/bin/bash

source ./gather_info.sh
source ./output_info.sh

if [ "$#" -ne 4 ]; then
    echo "Use: $0 FON CVET SHRIFTA FON ZNACHENI CVET SHRIFTA ZNACHENI"
    exit 1
fi

BG_TITLE=$1
FG_TITLE=$2
BG_VALUE=$3
FG_VALUE=$4

for param in "$BG_TITLE" "$FG_TITLE" "$BG_VALUE" "$FG_VALUE"; do
    if ! [[ "$param" =~ ^[1-6]$ ]];then
        echo "Error: parametrs must be 1 to 6"
        exit 1
    fi
done

if [ "$BG_TITLE" -eq "$FG_TITLE" ] || [ "$BG_VALUE" -eq "$FG_VALUE" ]; then
    echo "Error: Fon ne dolzen sovpadat s shriftom"
    exit 1
fi

declare -A fontcolors
fontcolors=( [1]="\e[97m" [2]="\e[91m" [3]="\e[92m" [4]="\e[94m" [5]="\e[95m" [6]="\e[90m" )

declare -A bgcolors
bgcolors=( [1]="\e[47m" [2]="\e[41m" [3]="\e[42m" [4]="\e[44m" [5]="\e[45m" [6]="\e[40m" )

gather_info

output_info
