#!/bin/bash

output_info() {

    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $TIMEZONE"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "UPTIME_SEC = $UPTIME_SEC"
    echo "IP = $IP"
    echo "MASK = $MASK"
    echo "GATEWAY = $GATEWAY"
    echo "RAM_TOTAL = $RAM_TOTAL"
    echo "RAM_USED = $RAM_USED"
    echo "RAM_FREE = $RAM_FREE"
    echo "SPACE_ROOT = $SPACE_ROOT"
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

    read -p "Do you want to save this information to a file? (Y/N): " response
    if [[ $response == "Y" || $response == "y" ]]; then
        TIMESTAMP=$(date +"%d_%m_%y_%H_%M_%S")
        FILENAME="${TIMESTAMP}.status"
        {
            echo "HOSTNAME = $HOSTNAME"
            echo "TIMEZONE = $TIMEZONE"
            echo "USER = $USER"
            echo "OS = $OS"
            echo "DATE = $DATE"
            echo "UPTIME = $UPTIME"
            echo "UPTIME_SEC = $UPTIME_SEC"
            echo "IP = $IP"
            echo "MASK = $MASK"
            echo "GATEWAY = $GATEWAY"
            echo "RAM_TOTAL = $RAM_TOTAL"
            echo "RAM_USED = $RAM_USED"
            echo "RAM_FREE = $RAM_FREE"
            echo "SPACE_ROOT = $SPACE_ROOT"
            echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
            echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
        } > "$FILENAME"
        echo "Information saved to $FILENAME"
    else
        echo "Information not saved."
    fi
}
