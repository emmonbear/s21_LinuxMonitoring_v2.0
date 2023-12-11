#!/bin/bash

error_message () {
    echo "$1"
}

validation () {
    # debug $@
    error_code=0
    if ! [[ -d $1 && $1 =~ ^'/' ]]; then
        error_message "Ошибка: Некорректный 1 аргумент. Введите абсолютный путь"
        error_code=1
    elif [[ ! $2 =~ ^[0-9]+$ || $2 -lt 1 ]]; then
        error_message "Ошибка: Некорректный 2 аргумент. Введите количество вложенных каталогов"
        error_code=1
    elif [[ ! $3 =~ ^[a-zA-Z]+$ || ${#3} -lt 2 || ${#3} -gt 7 ]]; then
        error_message "Ошибка: Некорректный 3 аргумент. Введите список букв английского алфавита"
        error_code=1
    elif [[ $4 -lt 1 ]]; then
        error_message "Ошибка: Некорректный 4 аргумент. Введите количество файлов в каждой созданной каталоге"
        error_code=1
    elif [[ ! $5 =~ ^([a-zA-Z]{2,7})\.([a-z]{1,3})$ ]]; then
        error_message "Ошибка: Некорректный 5 аргумент. Введите список букв английского алфавита, используемый в имени файла и расширении"
        error_code=1
    else
        local param_6=$6
        local param_6_size=${param_6%kb}
        if [[ ! $param_6 =~ ^([0-9]+kb)$ ]]; then
            error_message "Ошибка: Некорректный 6 аргумент. Введите размер файлов (в килобайтах, но не более 100)."
            error_code=1
        elif [[ $param_6_size -lt 1 || $param_6_size -gt 100 ]]; then
            error_message "Ошибка: Некорректный 6 аргумент. Введите размер файлов (в килобайтах, но не более 100)."
            error_code=1
        fi
    fi
    return $error_code
}

debug () {
    param_1=$1
    param_2=$2
    param_3=$3
    param_4=$4
    param_5=$5
    param_6=$6
    echo "param_1=$param_1"
    echo "param_2=$param_2"
    echo "param_3=$param_3"
    echo "param_4=$param_4"
    echo "param_5=$param_5"
    echo "param_6=$param_6"
}