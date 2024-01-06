#!/bin/bash

readonly RESET='\033[0m'
readonly RED='\033[1;31m'

# Вывод сообщения об ошибке и перенаправление его в stderr
# Parameters:
#   $1 - текст ошибки
error_message () {
  echo -e "${RED}Ошибка${RESET}: $1" >&2
}

# Поиск лог-файлов
# Global:
#   file_str
# Returns:
#   exit 1 - ни одного файла не найдено
find_files () {
  local files
  files=$(find ../04/ -type f -name "*access*")
  readonly files

  if [[ -z ${files} ]]; then
    error_message "Не найдено ни одного лога"
    exit 1
  fi

  file_str=""

  for file in ${files}; do
    file_str+="$file "
  done

  file_str=${file_str::-1}
  readonly file_str

}

# Сортировка по коду ответа
first_method () {
  rm -f code_sort.log
  awk '{print $0}' ${file_str} | sort -t' ' -k9,9 >> code_sort.log
}

# Вывод уникальных IP
second_method () {
  rm -f ip.log
  awk '{print $1}' ${file_str} | uniq | sort >> ip.log
}

# Вывод запросов с ошибками
third_method () {
  rm -f error.log
  awk '{ if ($9 >= 400) print $9": "$1,$4,$5,$6,$7,$8,$11,$12,$13,$14,$15,$16 }' ${file_str} >> error.log
}
