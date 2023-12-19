#!/bin/bash

error_message () {
    echo "$1"
}

validation () {
    error_code=0
    if [[ ! $# == 6 ]]; then
        error_message "Ошибка: Введите 6 аргументов"
        error_code=1
    elif ! [[ -d $1 && $1 =~ ^'/' ]]; then
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
