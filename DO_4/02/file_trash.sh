#!/bin/bash


function StartGen {
    nameLen=${#folder_name}
    offset=$nameLen

    if [[ nameLen -lt 5 ]]; then
        offset=(5 - $nameLen)
    fi
    
    subfoldersNumber=$((1 + $RANDOM % 100)) #количество файлов в каждой созданной папке. 
    randPath=`GetRandomPath`

    for (( i=$offset; i<($subfoldersNumber+$offset); i++ ))
    do
        dirPath=$(makeDir $randPath $i)    # длина имени каждой папки
        randPath=$dirPath

        randNum=$((1 + $RANDOM % 100))
        maXnameLen=$((randNum))

        for (( j=0; j<$maXnameLen; j++ ))
        do
                if [[ $(isOverMemory) == "true" ]]; then
                echo "Память закончилась!"
                echo -e "On folder:\n"$dirPath
                time_script
                exit              # если закончилось место
            else
                isDigit='^[0-9]+$'
                if [[ $j =~ $isDigit ]]; then
                    makeFile $dirPath $j
                fi
            fi
        done
    done
}

function makeDir {
    path=$randPath/$(FolderNameGen $2)_$('GetDate')
    sudo mkdir $path 2>/dev/null

    AddLogLine_folder $path $(GetDate)
    echo $path
}

function makeFile {
    FolderPath=$1

    baseCharset=${file_name%%.*}
    baselen=${#baseCharset}
    nameLen=$(($baselen))
    if [[ $nameLen -lt 5 ]]
    then
        let "nameLen+=(5-nameLen)"
    fi
    let "nameLen+=j"

    FileName=$(FileNameGen $nameLen)

    sudo bash -c "fallocate -l ${filesize^} $FolderPath/$FileName 2>/dev/null"

    AddLogLine_file $FolderPath/$FileName $(GetDate) $onlySize
}


function GetDate
{
    echo `date +%d%m%y`
}

function FolderNameGen {
    str=$folder_name
    maxLen=$1
    charsNumber=${#str}

    strlen=${#str}
    lastChar=${str:strlen-1}
    firstChar=${str:0:1}

    for (( i=$strlen; i<$maxLen; i++ ))
    do
        str="${str:0:1}${str}" #добавляем символ в строку
        let "strlen+=1" 
    done

    echo $str
}

function FileNameGen {
    strFile=$file_name

    extCharset=${strFile#*.} # получить расширение
    baseCharset=${strFile%%.*} # получить имя файла
    baselen=${#baseCharset}
    base=$baseCharset
    baseMaxLen=$1

    for (( i=$baselen; i<$baseMaxLen; i++ ))
    do
        base="${base:0:1}${base}" # добавляем символ в строку
        let "strlen+=1"
    done

    strlenExt=${#extCharset}
    maxLenExt=3
    ext=$extCharset
    if [[ $maxLenExt -lt 3 ]]
    then
        maxLenExt=3
    fi

    for (( i=$strlenExt; i<$maxLenExt; i++ ))
    do
        ext="${ext:0:1}${ext}" # добавляем символ в строку
        let "strlen+=1"
    done

    echo "$base.$ext"_"$(GetDate)"
}

function GetFreeSize {
    echo `df / -BM | awk '{print $4}' | tail -n 1 | cut -d 'M' -f1`
}

function isOverMemory {
    if [[ $(GetFreeSize) -lt "1024" ]]; then
        echo "true"
    else
        echo "false"
    fi
}

function AddLogLine_file {
    # путь
    fullPath=$1
    # дата создания
    date=$(date +"%d %b %Y %H:%M:%S")
    # размер файлa
    size=$3"Mb"
  
    line="$fullPath "---" $date "---" $size"

    echo $line >> log_trash.txt
}

function AddLogLine_folder {
    # путь
    fullPath=$1
    # дата создания
    date=$(date +"%d %b %Y %H:%M:%S")
  
    line="$fullPath "---" $date"

    echo $line >> log_trash.txt
}

function randomPathGen {
    echo `sudo bash -c "find / -maxdepth 2 -type d -writable | sort -R | tail -1 | grep -v -e "bin" -e "sbin" -e "run""`
}

function GetRandomPath {  #рандомный путь
    i=0
    while true; do
        RandPath=$(randomPathGen)

        if [[ -d "${RandPath}" && ! -L "${RandPath}" ]] ; then 
            echo $RandPath
            break
        fi
    done
}

function time_script {
    timeCompletedIn=`date +%H:%M:%S`
    END_TIME=$(date +%s)
    executionTime=$(( $END_TIME - $Start_time ))

    echo "Скрипт начал работу в = $(date '+%Y-%m-%d') $timeRunIn"
    echo "Скрипт закончил работу в = $(date '+%Y-%m-%d') $timeCompletedIn"
    echo "Время работы скрипта(в секундах) = $executionTime"

    echo "Скрипт начал работу в = $(date '+%Y-%m-%d') $timeRunIn" >> log_trash.txt
    echo "Скрипт закончил работу в = $(date '+%Y-%m-%d') $timeCompletedIn" >> log_trash.txt
    echo "Время работы скрипта(в секундах) = $executionTime" >> log_trash.txt
}