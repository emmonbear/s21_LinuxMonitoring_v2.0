#!/bin/bash

# Время в секундах (с начала эпохи)
# Parameters:
#   $1 - Время в формате DD.MM.YY HH:MM
time_per_sec () {
  local time="$1"
  IFS=". :" read -a time_array <<< "$time"
  local time_sec="$(date +%s -d "${time_array[2]}-${time_array[1]}-${time_array[0]} ${time_array[3]}:${time_array[4]}")"
  echo "$time_sec"
}

# Формирование регулярного выражения, для его последующего
# использование функцией grep
# Parameters:
#   $1 - Время начала в секундах
#   $2 - Время начала в секундах
regular () {
  local start=$(time_per_sec "$1")
  local finish=$(time_per_sec "$2")
  local current_seconds="$start"
  local str=""
  while [[ "$current_seconds" -le "$finish" ]]; do
    current_date=$(date -d "@$current_seconds" "+%d%m%y")
    str+=".*_$current_date.*|"
    current_seconds=$((current_seconds + 86400))
  done
  str="${str%?}"
  echo "$str"
}

# Первый способ очистки памяти
# Parameters:
#   $1 - Время начала
#   $2 - Время окончания
# Returns:
#   0 - успешное завершение программы, 1 - неуспешное завершение (требуется root)
second_way () {
  local -r start_time="$1"
  local -r finish_time="$2"

  local regex=$(regular "$start_time" "$finish_time")
  local result=($(find / -newermt "@$(time_per_sec "$start_time")" ! -newermt "@$(time_per_sec "$finish_time")" 2>/dev/null | grep -E "$regex"))
  
  local cnt_status_bar=0
  local -r finish=$(( ${#result[@]} ))

  source ./status_bar.sh
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
