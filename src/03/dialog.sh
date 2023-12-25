#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;36m'
RESET='\033[0m'
BOLD='\033[1m'
RED='\033[1;31m'
DELETE='\033[K'
UP='\033[A'

hello () {
    clear

    echo -e "${GREEN}${BOLD}====================================================================="
    echo -e "${GREEN}${BOLD}                          Добро пожаловать!                          "
    echo -e "${GREEN}${BOLD}=====================================================================${RESET}"
    echo -e "${BOLD}Приветствую Вас в утилите по очистке файловой системы."
    echo -e "Этот скрипт поможет вам избавиться от ненужных файлов и каталогов."
    echo -e "\nВыберите один из трех способов очистки системы:${RESET}"
    echo -e "1) По лог-файлу"
    echo -e "2) По дате и времени создания"
    echo -e "3) По маске имени (символы, нижнее подчёркивание и дата)"
}

choice_way () {
    echo -e -n "\n${BOLD}Введите номер способа (1/2/3): "
    read way
    if [[ $way =~ ^[1-3]$ ]]; then
        echo -e "${UP}${DELETE}Выбран способ: ${YELLOW}$way${RESET}\n"
    else
        echo -e "${UP}${DELETE}${UP}"
    fi
}

chosen_way_1 () {
    echo -e -n "${BOLD}"
    echo -e -n "Введите путь к лог файлу: "
    read log_path
    if [[ -z $log_path ]]; then
        log_path="../02/log.txt"
    fi
    echo -e "${UP}${DELETE}${BOLD}Выбран файл: ${YELLOW}${log_path}${RESET}\n"
}

chosen_way_2 () {
    error_code=0
    echo -e -n "${BOLD}Введите дату и время начала создания (ДД.ММ.ГГ ЧЧ:ММ): "
    read start_time
    validation_date "$start_time"
    if [[ $? -eq 1 ]]; then
        error_code=1
    else
        echo -e "${UP}${DELETE}Начало создания файлов:    ${YELLOW}${start_time}${RESET}"
        echo -e -n "${BOLD}Введите дату и время окончания создания (ДД.ММ.ГГ ЧЧ:ММ): "
        read end_time
        validation_date "$end_time"
        if [[ $? -eq 1 ]]; then
            error_code=1
        else
            echo -e "${UP}${DELETE}Окончание создания файлов: ${YELLOW}${start_time}${RESET}"
        fi
    fi
    return $error_code
}
