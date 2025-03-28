#!/bin/bash
. ./function.sh
# 1. Все записи, отсортированные по коду ответа esponse_code
# 2. Все уникальные IP, встречающиеся в записях unique_ips
# 3. Все запросы с ошибками (код ответа - 4хх или 5хх) requests
# 4. Все уникальные IP, которые встречаются среди ошибочных запросов  erroneous_requests
case ${1} in 
1 ) esponse_code;;
2 ) unique_ips;;
3 ) requests;;
4 ) erroneous_requests;;
5 ) rm -f *.log
rm -f *.txt;;
esac