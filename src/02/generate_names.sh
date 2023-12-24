#!/bin/bash

generate_name () {
    local name=$1
    local name_length=0
    if ((${#name} < 5)); then
        name_length=$((RANDOM % 35 + 5))
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
