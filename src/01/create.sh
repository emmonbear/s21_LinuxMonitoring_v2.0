#!/bin/bash

create_folders_and_files () {
    local date=$(date +"%d%m%y")
    local path=$1
    local count_folders=$2
    local list_folder_symbols=$3
    local count_files=$4
    local list_file_symbols=$(echo $5 | awk -F. '{print $1}')
    local file_extension=$(echo $5 | awk -F. '{print $2}')
    local size="${6%?}"
    local array_foldernames=()
    local array_filenames=()

    local tmp_1=0
    local tmp_2=0
    source ./generate_names.sh

    if ! array_foldernames=($(generate_list_names $count_folders $list_folder_symbols $path)); then
        echo "Ошибка: Невозможно создать $count_folders уникальных имен для каталогов"
        exit 1
    fi

    if ! array_filenames=($(generate_list_names $count_files $list_file_symbols $path)); then
        echo "Ошибка: Невозможно создать $count_files уникальных имен для файлов"
        exit 1
    fi

    for folder in "${array_foldernames[@]}"; do
        local dest_folder="$path${folder}_${date}"
        mkdir "$dest_folder"
        echo "По пути $path создан каталог ${folder}_${date} $(date +"%d.%m.%Y в %H:%M")" >> log.txt
        ((tmp_1++))
        for file in "${array_filenames[@]}"; do
            local dest_file="${path}${folder}_${date}/${file}_${date}.${file_extension}"
            fallocate -l $size "$dest_file"
            echo -e "\tПо пути $dest_folder создан файл ${file}_${date}.${file_extension} размером ${size}b $(date +"%d.%m.%Y в %H:%M")" >> log.txt
            ((tmp_2++))
            if [[ $(available_memory) -lt 1048576 ]]; then
                echo "Ошибка: В системе остается менее 1 Гб свободного места. Создано $tmp_1 каталогов, $tmp_2 файлов"
                exit 1
            fi
        done
    done
    echo "Лог записан в файл log.txt" 
}

available_memory () {
    echo "$(df / | grep /$ | awk '{print $4}')"
}