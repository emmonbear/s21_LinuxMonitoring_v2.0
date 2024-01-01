#!/bin/bash

main () {
  local -r time_1=$(date +%s)

  source ./dialog.sh
  dialog_hello

  source ./validation.sh
  validation "$@"

  if [[ $? -eq 0 ]]; then
    dialog_entered_parameters "$@"

    source ./create.sh
    create "$@"
    
    local -r time_2=$(date +%s)
    local -r execution_time=$((time_2 - time_1))

    draw_info "Время запуска скрипта: " "$(date -d "@$time_1" +"%d.%m.%Y %H:%M")\n"
    draw_info "Время завершения скрипта: " "$(date -d "@$time_2" +"%d.%m.%Y %H:%M")\n"
    draw_info "Скрипт выполнился за " "$execution_time секунд\n"

    echo "Время запуска скрипта: " "$(date -d "@$time_1" +"%d.%m.%Y %H:%M")" >> log.txt
    echo "Время завершения скрипта: " "$(date -d "@$time_2" +"%d.%m.%Y %H:%M")" >> log.txt

    dialog_end
  else
    dialog_end
    exit 1
  fi
}

main "$@"
