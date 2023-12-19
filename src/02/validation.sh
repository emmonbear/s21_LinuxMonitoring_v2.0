#!/bin/bash

error_message () {
    echo "$1"
}

validation () {
    local error_code=0
    if [[ ! $# == 3 ]]; then
        error_message "Ошибка: Введите 3 аргумента"
        error_code=1
    elif [[ ! $1 =~ ^([a-zA-Z]{2,7})$ ]]; then
        error_message "Ошибка: Некорректный первый аргумент. Введите список букв латинского алфавита (от 2 до 7 букв)"
        error_code=1
    elif [[ ! $2 =~ ^([a-zA-Z]{2,7})\.([a-z]{1,3})$ ]]; then
        error_message "Ошибка: Некорректный второй аргумент. Введите список букв латинского алфавита (от 2 до 7 букв для имени, от 1 до 3 для расширения)"
        error_code=1
    elif [[ ! $3 =~ ^([0-1]+Mb)$ ]]; then
        error_message "Ошибка: Некорректный третий аргумент. Введите размер файла (в Мегабайтах, но не более 100)"
        error_code=1
    else
        local param_3=$3
        local size=${param_3%Mb}
        if [[ $size -lt 1 || $size -gt 100 ]]; then
            error_message "Ошибка: Некорректный третий аргумент. Введите размер файла (в Мегабайтах, но не более 100)"
            error_code=1
        fi
    fi
    return $error_code
}