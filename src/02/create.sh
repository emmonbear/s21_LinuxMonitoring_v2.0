#!/bin/bash

create () {
    local list_folder_symbols=$1
    local list_file_symbols=$(echo $2 | awk -F. '{print $1}')
    local file_extension=$(echo $2 | awk -F. '{print $2}')
    local size=$3
    local array_path=($(find / -type d  2>/dev/null | grep -Ev '/bin$|/sbin$'))
    
    while true; do
        local current_path=${array_path[$(shuf -i 0-$((${#array_path[@]}-1)) -n 1)]}
        local folder_count=$(shuf -i 1-100 -n 1)
        folder_check=($(scan $current_path))
        for ((i=0; i<$folder_count; i++)); do
            if ! create_folders "$list_folder_symbols" "$current_path"; then
                break
            elif ! create_files $list_file_symbols $file_extension $size; then
                return 0
            fi
        done
    done
}

create_folders () {
    source ./generate_names.sh
    date=$(date +"%d%m%y")
    local list=$1
    local path=$2
    local name=""
    while true; do
        name=$(generate_name $list)
        if [[ ! " ${folder_check[@]} " =~ " ${name} " ]]; then
            folder_check+=($name)
            dest_folder="${path}/${name}_${date}"
            if mkdir "$dest_folder" 2>/dev/null; then
                echo "$dest_folder" >> log.txt
                return 0
            else
                return 1
            fi
        fi
    done
}

create_files () {
    source ./generate_names.sh
    local list=$1
    local file_extension=$2
    local size=${3%?}
    local file_count=$(shuf -i 1-100 -n 1)
    local name=""
    local dest_file=""
    local arr=()
    for ((i=0; i<file_count;i++)); do
        while true; do
            name=$(generate_name $list)
            if [[ ! " ${arr[@]} " =~ " ${name} " ]]; then
                arr+=($name)
                dest_file=${dest_folder}/${name}_${date}
                if fallocate -l $size $dest_file 2>/dev/null; then
                    echo "$dest_file $date ${size}b" >> log.txt
                fi
                if [[ $(available_memory) -le 1048576 ]]; then
                    echo "В системе остался 1 Гб памяти. Скрипт завершает работу"
                    return 1
                fi
                break
            fi
        done
    done
}

scan () {
    local generated_names=()
    for entry in "$1"/*; do
        if [[ -e "$entry" ]]; then
            name=$(basename "$entry")
            name=${name%%_*}
            generated_names+=(${name})
        fi
    done
    echo ${generated_names[@]}
}

available_memory () {
    echo "$(df / | grep /$ | awk '{print $4}')"
}
