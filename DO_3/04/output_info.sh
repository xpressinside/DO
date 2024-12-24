#!/bin/bash

output_info() {
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

    
}
