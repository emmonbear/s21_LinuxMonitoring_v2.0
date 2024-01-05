#!/bin/bash

# Первый способ очистки памяти
# Parameters:
#   $@ - Путь к лог файлу
# Returns:
#   0 - успешное завершение программы, 1 - неуспешное завершение (требуется root)
first_way () {   
  local path=$@
  validation_first_way $path
  if [[ $? -eq 0 ]]; then
    source ./status_bar.sh

    local cnt_status_bar=0
    local -r finish=$(wc -l < "$path")
    
    mapfile -t first_column < <(awk '{print $1}' "$path")
    
    for value in "${first_column[@]}"; do
      if ! rm -rf $value 2>/dev/null && ! rmdir $value 2>/dev/null; then
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
  fi
}
