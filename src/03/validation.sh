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

validation_date () {
    local error_code=0
    local date=$1
    local regex='^((0[1-9]|[1-2][0-9]|3[0-1])\.(0[1-9]|1[0-2])\.([0-9]{2}) ([0-1][0-9]|2[0-3])\:([0-5][0-9]))$'
    if [[ ! "$date" =~ $regex ]]; then
        error_message "${UP}${DELETE}${RED}Ошибка${RESET}: Введите дату в формате ДД.ММ.ГГ ЧЧ:ММ"
        error_code=1
    fi
    return $error_code
}

validation_date_1 () {
    local error_code=0
    local date_1="$1"
    local date_2="$2"
    if [[ $(time_per_sec "$date_1") -gt $(time_per_sec "$date_2") ]]; then
        error_message "${UP}${DELETE}${RED}Ошибка${RESET}: Время начала генерации файлов не может быть больше времени окончания"
        error_code=1
    fi
    return $error_code
}

