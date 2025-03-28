#!/bin/bash
rm -rf *.log
chmod +x *.sh
. ./test.sh

answer_list="200 201 400 401 403 404 500 501 502 503"
method_list="GET POST PUT PATCH DELETE"
date0="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
url_list="/forums/forums.txt /js/main.js /css/main.css /favicon.ico /downloads"
protocol_list="HTTP/2 HTTP/1.0 HTTP/1.1"

for (( i=5; i>0; i-- )); do
    time_shift=$(shuf -i 35-72 -n1)
    log_rows=$(shuf -i 100-1000 -n1)
    for (( j=0; j<$log_rows; j++ )); do
        
        IP_address="$(shuf -i 1-254 -n1)"."$(shuf -i 1-254 -n1)"."$(shuf -i 1-254 -n1)"."$(shuf -i 1-254 -n1)"
        answer="$(shuf -e ${answer_list} -n1)"
        method="$(shuf -e ${method_list}  -n1)"
        date1="[$(date -d "$date0 + $time_shift seconds"  +'%d/%b/%Y:%H:%M:%S %z')]"  
        url="$(shuf -e ${url_list}  -n1)"
        agent="$(shuf user_agent.txt -n1)"
        protocol="$(shuf -e ${protocol_list}  -n1)"
        some_number="$(shuf -i 1-120000 -n1)"

        echo $IP_address" - - "$date1" \""$method" "$url" "$protocol"\" "$answer" "$some_number" \"-\" \""$agent"\"" >> log$i.log
        ((time_shift+=$(shuf -i 35-72 -n1) ))
    done
    date0="$(date +%Y)-$(date +%m)-$(date +%d) 00:00:00 $(date +%z)"
    date0="$(date -d "$date0 - $((6-$i)) days" +'%Y-%m-%d')"  
done

# Список кодов ответа:
# 200 OK («хорошо»);
# 201 Created («создано»);
# 400 Bad Request («неправильный, некорректный запрос»);
# 401 Unauthorized («не авторизован (не представился)»);
# 403 Forbidden («запрещено (не уполномочен)»);
# 404 Not Found («не найдено»);
# 500 Internal Server Error («внутренняя ошибка сервера»);
# 501 Not Implemented («не реализовано»);
# 502 Bad Gateway («плохой, ошибочный шлюз»);
# 503 Service Unavailable («сервис недоступен»);
