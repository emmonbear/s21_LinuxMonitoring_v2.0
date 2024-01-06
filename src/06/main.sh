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

  echo ${file_str}
}

main () {
  if ! command -v goaccess &> /dev/null; then
    source ./install.sh
    install
  fi
  source ./sort.sh
  find_files
  goaccess -f ${file_str} --log-format=COMBINED --time-format=%T -o report.html
  xdg-open report.html
}
main ${@}
