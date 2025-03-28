#!/bin/bash

if [ $# != 0 ] ; then
    echo "error"
    exit 1
else
    while true; do
        if [[ -f /var/www/html/index.html ]]; then
            sudo rm /var/www/html/index.html
        fi
        sudo touch /var/www/html/index.html
        CPU="$(cat /proc/loadavg | awk '{print $1}')"
        Disk_Space="$(df /| grep / | awk '{print $2}')"
        Disk_Space_Used="$(df /| grep / | awk '{print $3}')"
        Memory="$(free | grep Mem | awk '{print $2}')"
        Memory_Used="$(free | grep Mem | awk '{print $3}')"
        echo -e "<html>" >> /var/www/html/index.html
        echo -e "  <head>" >> /var/www/html/index.html
        echo -e "  </head>" >> /var/www/html/index.html
        
        echo -e "  <body" >> /var/www/html/index.html

        echo -e  "<p># HELP cpu Take Cpu</p>" >> /var/www/html/index.html
        echo -e  "<p># TYPE cpu gauge</p>" >> /var/www/html/index.html
        echo -e  "<p>cpu $CPU</p>" >> /var/www/html/index.html
        echo -e  "<p>#HELP disk_space take disk_space</p>" >> /var/www/html/index.html
        echo -e  "<p>#TYPE disk_space gauge</p>" >> /var/www/html/index.html
        echo -e  "<p>disk_space $Disk_Space</p>" >> /var/www/html/index.html
        echo -e  "<p># HELP disk_space_used take disk_space_used</p>" >> /var/www/html/index.html
        echo -e  "<p># TYPE disk_space_used gauge</p>" >> /var/www/html/index.html
        echo -e  "<p>disk_space_used $Disk_Space_Used</p>" >> /var/www/html/index.html
        echo -e  "<p># HELP memory take memory</p>" >> /var/www/html/index.html
        echo -e  "<p># TYPE memory</p>" >> /var/www/html/index.html
        echo -e  "<p>memory $Memory</p>" >> /var/www/html/index.html
        echo -e  "<p># HELP memory take memory_used</p>" >> /var/www/html/index.html
        echo -e  "<p># TYPE memory_used</p>" >> /var/www/html/index.html
        echo -e  "<p>memory_used $Memory_Used</p>" >> /var/www/html/index.html
        echo -e "  </body>" >> /var/www/html/index.html
        echo -e "</html>" >> /var/www/html/index.html

        sleep 3
    done
fi