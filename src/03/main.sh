#!/bin/bash

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



declare -A colors
colors=( [1]="\e[97m" [2]="\e[91m" [3]="\e[92m" [4]="\e[94m" [5]="\e[95m" [6]="\e[90m" )

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
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}HOSTNAME = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$HOSTNAME"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}TIMEZONE = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$TIMEZONE"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}USER = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$USER\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}OS = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$OS\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}DATE = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$DATE\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}UPTIME = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$UPTIME\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}UPTIME_SEC = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$UPTIME_SEC\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}IP = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$IP\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}MASK = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$MASK\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}GATEWAY = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$GATEWAY\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}RAM_TOTAL = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$RAM_TOTAL\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}RAM_USED = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$RAM_USED\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}RAM_FREE = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$RAM_FREE\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}SPACE_ROOT = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}SPACE_ROOT\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}SPACE_ROOT_USED = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$SPACE_ROOT_USED\e[0m"
echo -e "${colors[$BG_TITLE]}${colors[$FG_TITLE]}SPACE_ROOT_FREE = ${colors[$BG_VALUE]}${colors[$FG_VALUE]}$SPACE_ROOT_FREE\e[0m"
