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
    local start=1
    local finish_1=$(( $count_folders * $count_files / 100 ))
    local finish_2=$(( $count_folders * $count_files * 3 ))
    source ./generate_names.sh
    draw_text "Формирование массивов уникальных имен:"
    source ./status_bar.sh
    process_status_bar $start $finish_1 &
    local pid=$!
    if ! array_foldernames=($(generate_list_names $count_folders $list_folder_symbols $path)); then
        error_message "Невозможно создать $count_folders уникальных имен для каталогов"
        dialog_end
        kill -SIGINT "$pid"
        exit 1
    fi
    
    if ! array_filenames=($(generate_list_names $count_files $list_file_symbols $path)); then
        error_message "Невозможно создать $count_files уникальных имен для файлов"
        kill -SIGINT "$pid"
        dialog_end
        exit 1
    fi
    echo -e "\r${UP}${DELETE}\n${DELETE}"
    echo -e "${UP}${UP}${UP}"
    draw_text "Генерация файлов и каталогов:"
    process_status_bar $start $finish_2 &
    pid=$!

    for folder in "${array_foldernames[@]}"; do
        local dest_folder="$path${folder}_${date}"
        if ! mkdir "$dest_folder" 2>/dev/null; then
            error_message "Невозможно создать каталог по пути ${path}. Требуются root права"
            kill -SIGINT "$pid"
            dialog_end
            exit 1
        else
            echo "${dest_folder} $(date +"%d.%m.%Y %H:%M")"  >> log.txt
            ((tmp_1++))
            for file in "${array_filenames[@]}"; do
                local dest_file="${path}${folder}_${date}/${file}_${date}.${file_extension}"
                fallocate -l $size "$dest_file"
                echo  " ${dest_file} $(date +"%d.%m.%Y %H:%M") ${size}b" >> log.txt
                ((tmp_2++))
                if [[ $(available_memory) -le 1048576 ]]; then
                    error_message "В системе остается менее 1 Гб свободного места. Создано $tmp_1 каталогов, $tmp_2 файлов"
                    kill -SIGINT "$pid"
                    dialog_end
                    exit 1
                fi
            done
        fi
    done
    echo -e "\r${UP}${DELETE}\n${DELETE}"
    echo -e "${UP}${UP}${UP}"
}

available_memory () {
    echo "$(df / | grep /$ | awk '{print $4}')"
}