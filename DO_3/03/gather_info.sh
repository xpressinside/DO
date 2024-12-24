#!/bin/bash

gather_info(){
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
}
