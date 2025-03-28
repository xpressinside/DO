function LogFileClearing {
    logs="$(cat ../02/log_trash.txt | awk -F'  ' '{print $1}'))"
    reg='^\/'
    for i in $logs:
    do
        if [[ $i =~ $reg ]]
        then
            sudo rm -rf $i
        fi
    done
}

function DateTimeClearing {
    echo "input should be like: $(date '+%Y-%m-%d %H:%M:%S')"

    read -p "enter the beginning of the search range for files to delete, date and time: " START_TIME
    read -p "enter the end of the file search range to delete, date: " END_TIME

    echo -e "deleting files created from "$START_TIME" to "$END_TIME"...\n"
    sudo bash -c "find / -newermt '$START_TIME' -not -newermt '$END_TIME' 2>/dev/null | xargs rm -r 2>/dev/null"
}

function NameMaskClearing {
    echo "input slould be like: foldername_$(date '+%d%m%y') or filename.ext_$(date '+%d%m%y')"
    read -p "enter the namemask: " nameMask

    echo "deleting files with mask = $nameMask..."
    find / -type f -name "*$nameMask*" 2>/dev/null | bash -c "sudo xargs rm -r 2>/dev/null"
    find / -type d -name "*$nameMask*" 2>/dev/null | bash -c "sudo xargs rm -r 2>/dev/null"
    echo -e "Done\n"
}