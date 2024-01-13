#!/bin/bash

main () {
  local start_time
  start_time=$(date +%s)
  readonly start_time

  source ./dialog.sh
  dialog_hello

  source ./validation.sh
  validation $@

  if [[ $? -eq 0 ]]; then
    dialog_entered_parameters $@
    draw_info "Время запуска скрипта: " "$(date -d "@$start_time" +"%d.%m.%Y %H:%M")\n"

    source ./create.sh 
    create $@

    local -r end_time=$(date +%s)
    local -r execution_time=$((end_time - start_time))
    
    draw_info "Скрипт выполнился за " "$execution_time секунд\n"
    draw_info "Лог записан в файл: " "log.txt"
    dialog_end
  else
    dialog_end
    exit 1
  fi
}

main "$@"
