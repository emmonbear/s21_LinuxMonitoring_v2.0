#!/bin/bash

error_message () {
    echo "$1"
}
validation_first_way () {
    local error_code=0
    local path=$1
    if [[ ! -f $path ]]; then
        error_message "Ошибка: Файл $path не найден"
        error_code=1
    fi
    return $error_code
}