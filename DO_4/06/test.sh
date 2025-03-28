#!/bin/bash
if [ "$#" != 1 ]; then
    echo "Неверное количество аргументов."
    exit 1
fi
# Поиск
valid='1-4'
if [[ $parametr_zapusk =~ [^$valid] ]]; then
    echo "Команда содержит символы введите 1-4 для поиска."
    exit 1
fi