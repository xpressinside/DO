#!/bin/bash


#if [ "$#" -ne 4 ]; then
#    echo "Use: $0 FON CVET SHRIFTA FON ZNACHENI CVET SHRIFTA ZNACHENI"
#    exit 1
#fi

source config.ini

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

# Gather system information
HOSTNAME=$(hostname)
TIMEZONE=$(cat /etc/timezone)$(date +" UTC %:z")
USER=$(whoami)
OS=$(lsb_release -d | awk -F"\t" '{print $2}')
DATE=$(date +"%d %B %Y %H:%M:%S")
UPTIME=$(uptime -p)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}' | cut -d. -f1)
IP=$(hostname -I | awk '{print $1}')
MASK=$(ipcalc $(ip -o -f inet addr show | awk 'NR==2 {print $4}')| awk '/Netmask/ {print $2}')
GATEWAY=$(ip route | grep default | awk '{print $3}')
RAM_TOTAL=$(free -g | awk '/Mem:/ {printf "%.3f GB\n", $2}')
RAM_USED=$(free -g | awk '/Mem:/ {printf "%.3f GB\n", $3}')
RAM_FREE=$(free -g | awk '/Mem:/ {printf "%.3f GB\n", $4}')
SPACE_ROOT=$(df / | awk 'NR==2 {printf "%.2f MB\n", $2 / 1024}')
SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf "%.2f MB\n", $3 / 1024}')
SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf "%.2f MB\n", $4 / 1024}')

# Output gathered information
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}HOSTNAME = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$HOSTNAME\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}TIMEZONE = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$TIMEZONE\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}USER = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$USER\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}OS = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$OS\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}DATE = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$DATE\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}UPTIME = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$UPTIME\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}UPTIME_SEC = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$UPTIME_SEC\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}IP = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$IP\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}MASK = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$MASK\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}GATEWAY = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$GATEWAY\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}RAM_TOTAL = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$RAM_TOTAL\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}RAM_USED = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$RAM_USED\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}RAM_FREE = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$RAM_FREE\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}SPACE_ROOT = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}SPACE_ROOT\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}SPACE_ROOT_USED = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$SPACE_ROOT_USED\e[0m"
echo -e "${bgcolors[$BG_TITLE]}${fontcolors[$FG_TITLE]}SPACE_ROOT_FREE = ${bgcolors[$BG_VALUE]}${fontcolors[$FG_VALUE]}$SPACE_ROOT_FREE\e[0m"

echo ""

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
