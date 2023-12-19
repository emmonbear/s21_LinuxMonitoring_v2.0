#!/bin/bash

generate_name () {
    local name=$1
    local name_length=0
    if ((${#name} < 4)); then
        name_length=$((RANDOM % 35 + 4))
    else
        name_length=$((RANDOM % 35 + ${#name}))
    fi
    for ((j=0; j<$name_length - ${#name}; j++)); do
        local random_index=$((RANDOM % ${#name}))
        local char=${name:$random_index:1}
        local end_str=${name:$random_index}
        name=${name:0:$random_index}
        name=${name}${char}${end_str}
    done
    echo $name
}

scan () {
    local generated_names=()
    local date=$(date +"%d%m%y")
    for entry in "$1"/*; do
        if [[ -e "$entry" ]]; then
            name=$(basename "$entry")
            name=${name%%_*}
            generated_names+=(${name})
        fi
    done
    echo ${generated_names[@]}
}

generate_list_names () {
    local count=$1
    local list=$2
    local path=$3
    local name_length=0
    local max_retries=1000
    local generated_array=()
    local generated_names=$(scan $path)
    source ./generate_names.sh
    for ((i=0; i<$count;i++)); do
        local retries=0
        while true; do
            if [[ $retries -eq $max_retries ]]; then
                return 1
            else
                local name=$(generate_name $list)
                if [[ ! " ${generated_names[@]} " =~ " ${name} " ]]; then
                    generated_names+=($name)
                    generated_array+=($name)
                    break
                fi
                ((retries++))
            fi
        done
    done
    echo "${generated_array[@]}"
}
