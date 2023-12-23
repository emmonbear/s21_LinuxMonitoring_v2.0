#!/bin/bash

error_message () {
    echo "$1"
}

validation () {
    error_code=0
    if ! [[ $# -eq 1 ]]; then
        error_message "Ошибка: Введите 1 параметр"
        error_code=1
    elif ! [[ $1 =~ ^[1-3]$ ]]; then
        error_message "Ошибка: Выберите режим (1, 2 или 3)"
        error_code=1
    fi
    return $error_code
}
