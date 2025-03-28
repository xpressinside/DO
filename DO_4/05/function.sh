#!/bin/bash
# 1. Все записи, отсортированные по коду ответа esponse_code
# 2. Все уникальные IP, встречающиеся в записях unique_ips
# 3. Все запросы с ошибками (код ответа - 4хх или 5хх) requests
# 4. Все уникальные IP, которые встречаются среди ошибочных запросов  erroneous_requests

function esponse_code {
    if [[ -f sortlog1.log ]]; then
        rm -f sortlog1.log
    fi
    arrcods=(200 201 400 401 403 404 500 501 502 503)
    number_mass=${#arrcods[*]}
    for (( i=0; i < number_mass; i++ )); do
        for ((j=1; j<=5; j++));do
        awk '$9 == '${arrcods[i]}'  { print $0 }' ../04/log${j}.log >> sortlog1.log
        done
    done  
}

function unique_ips {
    if [[ -f sortlog2.log ]]; then
        rm -f sortlog2.log
    fi
    for ((j=1; j<=5; j++));do
        awk '{print $1}' ../04/log${j}.log >> iplist.txt
    done
    sort iplist.txt | uniq  >> sortlog2.log
    rm -f *.txt
}

function requests {
    if [[ -f sortlog3.log ]]; then
        rm -f sortlog3.log
    fi
    arrcods=(400 401 403 404 500 501 502 503)
    number_mass=${#arrcods[*]}
    for (( i=0; i < number_mass; i++ )); do
        for ((j=1; j<=5; j++));do
        awk '$9 == '${arrcods[i]}'  { print $9 " " $6 " " $7 $8}' ../04/log${j}.log >> sortlog3.log
        done
    done  
}

function erroneous_requests {
    if [[ -f sortlog4.log ]]; then
        rm -f sortlog4.log
    fi
    arrcods=(400 401 403 404 500 501 502 503)
    number_mass=${#arrcods[*]}
    for (( i=0; i < number_mass; i++ )); do
        for ((j=1; j<=5; j++));do
        awk '$9 == '${arrcods[i]}'  { print $1 }' ../04/log${j}.log >> sortlog.txt
        done
    done  
        sort sortlog.txt | uniq  >> sortlog4.log
    rm -f *.txt
}