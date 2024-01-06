#!/bin/bash

readonly RESET='\033[0m'
readonly RED='\033[1;31m'

# Вывод сообщения об ошибке и перенаправление его в stderr
# Parameters:
#   $1 - текст ошибки
error_message () {
  echo -e "${RED}Ошибка${RESET}: $1" >&2
}

# Валидация входных данных
# Parameters:
#   $@
# Returns:
#   0 - корректные аргументы, 1 - некорректные аргументы
validation () {
  local error_code=0

  if [[ ! $# -eq 1 ]]; then
    error_message "Некорретный аргумент"
    error_code=1
  elif [[ ! ${1} =~ ^[1-4]$ ]]; then
    error_message "Некорретный аргумент"
    error_code=1
  fi
  
  return ${error_code}
}