#!/bin/bash

error_message () {
    echo -e "$1"
}
validation_first_way () {
    local error_code=0
    local path=$1
    if [[ ! $# -eq 1 ]]; then
        error_message "${RED}Ошибка${RESET}: Введите один аргумент (путь к лог файлу)"
        error_code=1
    elif [[ ! -f $path ]]; then
        error_message "${RED}Ошибка${RESET}: Файл $path не найден"
        error_code=1
    fi
    return $error_code
}