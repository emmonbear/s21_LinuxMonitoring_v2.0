#!/bin/bash

# Вывод сообщения об ошибке и перенаправление его в stderr
# Parameters:
#   $1 - текст ошибке
error_message () {
  echo -e "${UP}${DELETE}${RED}Ошибка${RESET}: $1"
}

# Валидация входных данных
# Parameters:
#   $@
# Returns:
#   0 - корректный аргумент, 1 - некорректный аргумент
validation_first_way () {
  local error_code=0
  local path=$1
  if [[ ! $# -eq 1 ]]; then
    echo ""
    error_message "Введите один аргумент (путь к лог файлу)"
    error_code=1
  elif [[ ! -f $path ]]; then
    echo ""
    error_message "Файл $path не найден"
    error_code=1
  fi
  return $error_code
}

# Валидация формата дат для второго способа очистки памяти
# Parameters:
#   $1 - дата
# Returns:
#   0 - корректный аргумент, 1 - некорректный аргумент
validation_date () {
  local error_code=0

  local date=$1
  local regex='^((0[1-9]|[1-2][0-9]|3[0-1])\.(0[1-9]|1[0-2])\.([0-9]{2}) ([0-1][0-9]|2[0-3])\:([0-5][0-9]))$'

  if [[ ! "$date" =~ $regex ]]; then
    error_message "Введите дату в формате ДД.ММ.ГГ ЧЧ:ММ" #+
    error_code=1
  fi

  return $error_code
}

# Сравнить, что start <= end
# Parameters:
#   $1 - дата
# Returns:
#   0 - корректный аргумент, 1 - некорректный аргумент
validation_date_1 () {
  local error_code=0

  local -r date_1="$1"
  local -r date_2="$2"

  if [[ $(time_per_sec "$date_1") -gt $(time_per_sec "$date_2") ]]; then
    delete_up
    error_message "Время начала генерации файлов не может быть больше времени окончания" #+
    error_code=1
  fi

  return $error_code
}

# Валидация маски
# Parameters:
#   $1 - маска
# Returns:
#   0 - корректный аргумент, 1 - некорректный аргумент
validation_mask () {
  local error_code=0

  local -r mask="$1"

  if [[ ! $mask =~ ^([a-zA-Z]{2,7})\_((0[1-9]|[1-2][0-9]|3[0-1])(0[1-9]|1[0-2])([0-9]{2}))$ ]]; then
    delete_up
    error_message "Введите аргумент в формате symbols_MMDDYY" #+
    error_code=1
  fi

  return $error_code
}
