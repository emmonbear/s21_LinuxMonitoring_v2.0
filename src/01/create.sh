#!/bin/bash

generate_list_foldernames () {
    number_files=$1
    local list=$2
    generated_names=()
    for ((i=0; i<$number_files;i++)); do
        local name="$list"
        local name_length=0
        while true; do
            if ((${#list} < 4)); then
                name_length=$((RANDOM % 12 + 4))
            else
                name_length=$((RANDOM % 12 + ${#list}))
            fi
            for ((j=0; j<$name_length - ${#list}; j++)); do
                random_index=$((RANDOM % ${#name}))
                char=${name:$random_index:1}
                end_str=${name:$random_index}
                name=${name:0:$random_index}
                name=${name}${char}${end_str}
            done
            if [[ ! " ${generated_names[@]} " =~ " ${name} " ]]; then
                generated_names+=("$name")
                # echo "$name"
                break
            else
                continue
            fi
        done
    done
}

create_folders () {
    local date=$(date +"%d%m%y")
    generate_list_foldernames $2 $3
    for ((i=0; i<${#generated_names[@]}; i++)); do
        generated_names[i]="${generated_names[i]}_$date"
        mkdir -p "$1/${generated_names[i]}"
        # echo "${generated_names[i]}"
    done
}
# create_folders $1 $2