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

# Выделить текст жирным и оставить курсор на этой строке
draw_text_flag_n () {
  echo -e -n "${BOLD}${1}${RESET}"
}

# 
dialog_hello () {
  clear
  draw_frame "====================================================================="
  draw_frame "                          Добро пожаловать!                          "
  draw_frame "====================================================================="
  draw_text "Приветствую Вас в утилите по очистке файловой системы."
  draw_text "Этот скрипт поможет вам избавиться от ненужных файлов и каталогов."
  echo ""
  draw_text "Выберите один из трех способов очистки системы:"
  echo " 1) По лог-файлу"
  echo " 2) По дате и времени создания"
  echo " 3) По маске имени (символы, нижнее подчёркивание и дата)"
  echo ""
}

# Сместить курсор наверх и удалить строку
delete_up () {
  echo -e -n "\r${UP}${DELETE}"
}

# $1 жирный $2 желтый
draw_info () {
  echo -e "${BOLD}${1}${YELLOW}${2}${RESET}"
}

# Диалог: выбор способа очистки памяти
dialog_choice_way () {
  draw_text "${BOLD}Введите номер способа (1/2/3): "
  read way
  if [[ $way =~ ^[1-3]$ ]]; then
    delete_up
    delete_up
    draw_info "Выбран способ: " "$way"
    echo ""
  else
    delete_up
  fi
}

# Диалог: первый способ очистки памяти
# Returns:
#   0 - корректные аргументы, 1 - некорректные аргументы
dialog_chosen_way_1 () {
  draw_text_flag_n "Введите путь к лог файлу: "
  read log_path
  if [[ -z $log_path ]]; then
    log_path="../02/log.txt"
  fi
  delete_up
  draw_info "Выбран файл: " "${log_path}"
  echo ""
}

# Диалог: второй способ очистки памяти
# Returns:
#   0 - корректные аргументы, 1 - некорректные аргументы
dialog_chosen_way_2 () {
  local error_code=0
  draw_text_flag_n "Введите дату и время начала создания (ДД.ММ.ГГ ЧЧ:ММ): "
  read start_time
  validation_date "$start_time"
  if [[ $? -eq 1 ]]; then
    error_code=1
  else
    delete_up
    draw_info "Начало создания файлов:    " "${start_time}"
    draw_text_flag_n "Введите дату и время окончания создания (ДД.ММ.ГГ ЧЧ:ММ): "
    read end_time
    validation_date "$end_time"
    if [[ $? -eq 1 ]]; then
      error_code=1
    else
      delete_up
      draw_info "Окончание создания файлов: " "${end_time}"
      validation_date_1 "$start_time" "$end_time"
      if [[ $? -eq 1 ]]; then
          error_code=1
      fi
    fi
  fi

  return $error_code
}

# Диалог: третий способ очистки памяти
# Returns:
#   0 - корректные аргументы, 1 - некорректные аргументы
dialog_chosen_way_3 () {
  local error_code=0
  draw_info "Введите маску имени в формате:" "symbols_MMDDYY"
  read name_mask
  validation_mask "$name_mask"
  if [[ $? -eq 1 ]]; then
    error_code=1
  else
    delete_up
    delete_up
    draw_info "Выбрана маска:" "${name_mask}"
    echo ""
  fi
  return $error_code
}

