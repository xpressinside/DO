#!/bin/bash

function start {
    nameLen=${#folder_name}
    offset=$nameLen

    if [[ nameLen -lt 4 ]]; then
        offset=(4 - $nameLen)
    fi

    for (( i=$offset; i<($foldersNumber+$offset); i++ )); do
        dirPath=$(gen_dir $absolutePath $i)    # длина имени каждой папки
        absolutePath=$dirPath

        for (( j=0; j<$file_number; j++ )); do
            if [[ $(isOverMemory) == "true" ]]; then
                echo "Ошибка - закончилось место, требуется минимум 1ГБ свободного места"
                exit              #если закончилось место
            else
                gen_file $dirPath $j
            fi
        done
    done
}

function gen_dir {
    path=$absolutePath/$(FolderNameGen $2)_$('gen_date')  #создание папки
    sudo mkdir -p $path
    log_folder $path $(gen_date)
    echo $path
}

function gen_file {
    FolderPath=$1  
    baseCharset=${file_name%%.*}  #создание файла
    baselen=${#baseCharset}
    nameLen=$(($baselen))
    if [[ $nameLen -lt 4 ]]; then
        let "nameLen+=(4-nameLen)"
    fi
    let "nameLen+=j"

    # путь к файлу
    FileName=$(FileNameGen $nameLen)

    # дата создания
    log_file $FolderPath/$FileName $(gen_date) $onlySize


    # размер файлa
    sudo fallocate -l ${filesize^} $FolderPath/$FileName

}

function gen_date
{
    echo `date +%d%m%y` #дата к папке и файлу
}

function FolderNameGen {
    str=$folder_name  #создание имя для папки
    maxLen=$1
    charsNumber=${#str}

    strlen=${#str}
    lastChar=${str:strlen-1}
    firstChar=${str:0:1}

    for (( i=$strlen; i<$maxLen; i++ )); do
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

    for (( i=$baselen; i<$baseMaxLen; i++ )); do
        base="${base:0:1}${base}" # добавляем символ в строку
        let "strlen+=1"
    done

    strlenExt=${#extCharset}
    maxLenExt=3
    ext=$extCharset
    if [[ $maxLenExt -lt 3 ]]; then
        maxLenExt=3
    fi

    for (( i=$strlenExt; i<$maxLenExt; i++ )); do
        ext="${ext:0:1}${ext}" # добавляем символ в строку
        let "strlen+=1"
    done

    echo "$base.$ext"_"$(gen_date)"
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

function log_file {
    # путь
    fullPath=$1
    # дата создания
    date=$(date +"%d %b %Y %H:%M:%S")
    # размер файлa
    size=$3"kb"
  
    line="$fullPath "=======" $date "=======" $size"

    echo $line >> creation.log
}

function log_folder {
    # путь
    fullPath=$1
    # дата создания
    date=$(date +"%d %b %Y %H:%M:%S")
  
    line="$fullPath "=======" $date"

    echo $line >> creation.log
}