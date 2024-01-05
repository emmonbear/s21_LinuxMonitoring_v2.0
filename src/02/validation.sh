#!/bin/bash

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
  if [[ ! $# == 3 ]]; then
    error_message "Введите 3 аргумента"
    error_code=1
  elif [[ ! $1 =~ ^([a-zA-Z]{2,7})$ ]]; then
    error_message "Некорректный первый аргумент. Введите список букв латинского алфавита (от 2 до 7 букв)"
    error_code=1
  elif [[ ! $2 =~ ^([a-zA-Z]{2,7})\.([a-z]{1,3})$ ]]; then
    error_message "Некорректный второй аргумент. Введите список букв латинского алфавита (от 2 до 7 букв для имени, от 1 до 3 для расширения)"
    error_code=1
  elif [[ ! $3 =~ ^([0-9]+Mb)$ ]]; then
    error_message "Некорректный третий аргумент. Введите размер файла (в Мегабайтах, но не более 100)"
    error_code=1
  else
    local param_3=$3
    local size=${param_3%Mb}
    if [[ $size -lt 1 || $size -gt 100 ]]; then
      error_message "Некорректный третий аргумент. Введите размер файла (в Мегабайтах, но не более 100)"
      error_code=1
    fi
  fi
  return $error_code
}

# Проверка, что пользователь у log.txt не поменялся на root
# В этом случае файлы и директории будут создаваться, но записи в log.txt не будет
# Returns:
#   1 - требуется root
check_user () {
  if ! echo "" 2>/dev/null >> log.txt; then
    error_message "Нет возможности записать в лог файл. Требуются root права"
    exit 1
  fi
}
