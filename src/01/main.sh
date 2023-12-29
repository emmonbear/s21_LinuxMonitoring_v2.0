#!/bin/bash

source ./dialog.sh
dialog_hello

source ./validation.sh
validation $@

readonly path=$1
readonly count_folders=$2
readonly list_folder_symbols=$3
readonly count_files=$4
readonly list_file_symbols=$(echo $5 | awk -F. '{print $1}')
readonly file_extension=$(echo $5 | awk -F. '{print $2}')
readonly size="${6%?}"

readonly start_time=$(date +%s)

if [[ $? -eq 0 ]]; then
    dialog_entered_parameters $@
    draw_info "Время запуска скрипта: " "$(date -d "@$start_time" +"%d.%m.%Y %H:%M")\n"

    source ./create.sh
    create_folders_and_files $@

    readonly end_time=$(date +%s)
    readonly execution_time=$((end_time - start_time))
    
    draw_info "Скрипт выполнился за " "$execution_time секунд\n"
    draw_info "Лог записан в файл: " "log.txt"
    dialog_end
else
    dialog_end
    exit 1
fi
