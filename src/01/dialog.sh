#!/bin/bash

readonly YELLOW='\033[1;33m'
readonly GREEN='\033[1;36m'
readonly RESET='\033[0m'
readonly BOLD='\033[1m'
readonly RED='\033[1;31m'
readonly DELETE='\033[K'
readonly UP='\033[A'

# Нарисовать рамку
draw_frame () {
    echo -e "${GREEN}${BOLD}${1}${RESET}"
}

# Выделить текст жирным
draw_text () {
  echo -e "${BOLD}${1}${RESET}"
}

# Форма для отображения параметров
draw_parameters () {
  echo -e "  ${1}${YELLOW}${2}${RESET}"
}

# $1 жирный $2 желтый
draw_info () {
  echo -e "${BOLD}${1}${YELLOW}${2}${RESET}"
}

# Сместить курсор наверх и удалить строку
delete_up () {
  echo -e -n "\r${UP}${DELETE}"
}

# 
dialog_hello () {
  clear
  draw_frame "====================================================================="
  draw_frame "                          Добро пожаловать!                          "
  draw_frame "====================================================================="
  draw_text "Приветствую Вас в утилите по засорению файловой системы."
  echo
}

# 
dialog_entered_parameters () {
  draw_text "Введенные параметры:"
  draw_parameters "Абсолютный путь:                                  " "${1}"
  draw_parameters "Количество вложенных каталогов:                   " "${2}"
  draw_parameters "Список букв, используемых в названиях каталогов:  " "${3}"
  draw_parameters "Количество файлов, создаваемых в каждом каталоге: " "${4}"
  draw_parameters "Список букв, используемых в названиях файлов:     " "${5}"
  draw_parameters "Размер файлов:                                    " "${6}"
  echo
}

# 
dialog_end () {
  draw_frame "====================================================================="
}
