#!/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;36m'
RESET='\033[0m'
BOLD='\033[1m'
RED='\033[1;31m'
DELETE='\033[K'
UP='\033[A'

draw_frame () {
    echo -e "${GREEN}${BOLD}${1}${RESET}"
}

draw_text () {
    echo -e "${BOLD}${1}${RESET}"
}

draw_parameters () {
    echo -e "  ${1}${YELLOW}${2}${RESET}"
}

draw_info () {
    echo -e "${BOLD}${1}${YELLOW}${2}${RESET}"
}

dialog_hello () {
    clear
    draw_frame "====================================================================="
    draw_frame "                          Добро пожаловать!                          "
    draw_frame "====================================================================="
    draw_text "Приветствую Вас в утилите по засорению файловой системы."
    echo
}

dialog_entered_parameters () {
    draw_text "Введенные параметры:"
    draw_parameters "Список букв, используемых в названиях каталогов:  " "${1}"
    draw_parameters "Список букв, используемых в названиях файлов:     " "${2}"
    draw_parameters "Размер файлов:                                    " "${3}"
    echo
}

dialog_end () {
    draw_frame "====================================================================="
}
