function check {
# Параметр 1 - режим очистки. 
if [[ $1 =~ ^[1-3]+$ ]];then
    mode=$1
else
    echo "ERROR: Аргумент содержит нечисловое значение или значение в недопустимом диапазоне"
    exit
fi
}