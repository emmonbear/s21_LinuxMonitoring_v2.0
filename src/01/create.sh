#!/bin/bash

generate_list_names () {
    local count=$1
    local list=$2
    local generated_names=()
    for ((i=0; i<$count;i++)); do
        local name="$list"
        local name_length=0
        while true; do
            if ((${#list} < 4)); then
                name_length=$((RANDOM % 12 + 4))
            else
                name_length=$((RANDOM % 12 + ${#list}))
            fi
            for ((j=0; j<$name_length - ${#list}; j++)); do
                local random_index=$((RANDOM % ${#name}))
                local char=${name:$random_index:1}
                local end_str=${name:$random_index}
                name=${name:0:$random_index}
                name=${name}${char}${end_str}
            done
            if [[ ! "${generated_names[@]}" =~ " ${name} " ]]; then
                generated_names+=("$name")
                break
            fi
        done
    done
    generated_array=("${generated_names[@]}")
}

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
    generate_list_names $count_folders $list_folder_symbols
    array_foldernames=("${generated_array[@]}")

    for folder in "${array_foldernames[@]}"; do
        mkdir -p "$path/${folder}_${date}"
        generate_list_names $count_files $list_file_symbols
        array_filenames=("${generated_array[@]}")
        for file in "${array_filenames[@]}"; do
            fallocate -l $size ${path}/${folder}_${date}/${file}.${file_extension}_${date}
        done
    done
        

    

}


