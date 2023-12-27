#!/bin/bash

clear

source ./validation.sh
source ./dialog.sh

dialog_hello
start_time=$(date +%s)
validation $@
if [[ $? -eq 0 ]]; then
    dialog_entered_parameters $@
    source ./create.sh
    draw_info "Время запуска скрипта: " "$(date -d "@$start_time" +"%d.%m.%Y %H:%M")\n"
    create_folders_and_files $@
    end_time=$(date +%s)
    execution_time=$((end_time - start_time))
    echo -e -n "\r${DELETE}"
    draw_info "Скрипт выполнился за " "$execution_time секунд\n"
    draw_info "Лог записан в файл: " "log.txt"
    dialog_end
else
    dialog_end
    exit 1
fi
