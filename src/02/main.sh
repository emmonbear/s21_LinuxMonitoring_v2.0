#!/bin/bash

main () {
  local time_1
  time_1=$(date +%s)
  readonly time_1

  source ./dialog.sh
  dialog_hello

  source ./validation.sh
  check_user
  validation "$@"

  if [[ $? -eq 0 ]]; then
    dialog_entered_parameters "$@"

    source ./create.sh
    create "$@"
    
    local time_2
    time_2=$(date +%s)
    readonly time_2

    local execution_time
    execution_time=$((time_2 - time_1))
    readonly execution_time

    draw_info "Время запуска скрипта: " "$(date -d "@$time_1" +"%d.%m.%y %H:%M")\n"
    draw_info "Время завершения скрипта: " "$(date -d "@$time_2" +"%d.%m.%y %H:%M")\n"
    draw_info "Скрипт выполнился за " "$execution_time секунд\n"

    echo "Время запуска скрипта: " "$(date -d "@$time_1" +"%d.%m.%y %H:%M")" >> log.txt
    echo "Время завершения скрипта: " "$(date -d "@$time_2" +"%d.%m.%y %H:%M")" >> log.txt

    dialog_end
  else
    dialog_end
    exit 1
  fi
}

main "$@"
