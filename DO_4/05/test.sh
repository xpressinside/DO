#!/bin/bash
if [ "$#" != 1 ]; then
    echo "Неверное количество аргументов."
    exit 1
fi
valid1='1-5'
if [[ $1 =~ [^$valid1] ]]; then
    echo "Неверное значение аргументов."
    exit 1
fi
if [[ ${#1} -gt 1 ]]; then
    echo "Неверное количество аргументов/."
    exit 1
fi