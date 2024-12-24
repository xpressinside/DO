#!/bin/bash

source config.ini
source ./gather_info.sh
source ./output_info.sh

get_color_name() {
    case $1 in
        1) echo "white" ;;
        2) echo "red" ;;
        3) echo "green" ;;
        4) echo "blue" ;;
        5) echo "purple" ;;
        6) echo "black" ;;
    esac
}

BG_TITLE=${1:-$column1_background}
FG_TITLE=${2:-$column1_font_color}
BG_VALUE=${3:-$column2_background}
FG_VALUE=${4:-$column2_font_color}

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

if [[ -z "$1" ]]; then
    echo "Column 1 background = default (red)"
else
    echo "Column 1 background = $BG_TITLE ($(get_color_name $BG_TITLE))"
fi

if [[ -z "$2" ]]; then
    echo "Column 1 font color = default (blue)"
else
    echo "Column 1 font color = $FG_TITLE ($(get_color_name $FG_TITLE))"
fi

if [[ -z "$3" ]]; then
    echo "Column 2 background = default (purple)"
else
    echo "Column 2 background = $BG_VALUE ($(get_color_name $BG_VALUE))"
fi

if [[ -z "$4" ]]; then
    echo "Column 2 font color = default (white)"
else
    echo "Column 2 font color = $FG_VALUE ($(get_color_name $FG_VALUE))"
fi