#!/bin/bash

# Формирование регуляроного выражения для grep
# Parameters:
#   $1 - Список букв латиницы
#   $2 - Дата создания (ДДММГГ)
regular () {
  local alphabet="$1"
  local date="$2"
  local result=""
  for ((i=0; i<${#alphabet}; i++)); do
      result+=".*${alphabet:i:1}"
  done
  result+=".*_${date}.*"
  echo "$result"
}

# Третий способ очистки памяти
# Parameters:
#   $1 - Маска
# Returns:
#   0 - успешное завершение программы, 1 - неуспешное завершение (требуется root)
third_way () {
  local -r mask="$1"
  IFS="_" read alphabet date <<< "$mask"
  local -r regex=$(regular "$alphabet" "$date")
  local -r result=($(find / 2>/dev/null | grep -E "$regex"))

  source ./status_bar.sh
  local -r finish=$(( ${#result[@]} ))
  local cnt_status_bar=0
  local pid=$!
  for path in ${result[@]}; do
    if ! rm -rf $path 2>/dev/null && ! rmdir $path 2>/dev/null; then
      echo ""
      error_message "Не удается очистить файловую систему"
      echo "Возможно требуется запустить скрипт с root правами"
      return 1
    else
      ((cnt_status_bar++))
      status_bar $cnt_status_bar $finish
    fi
  done
  echo
  delete_up
  draw_text "Система была очищена"
}

