#!/bin/bash

first_way () {

local path=$@
source ./validation.sh
validation_first_way $path
if [[ $? -eq 0 ]]; then
    mapfile -t first_column < <(awk '{print $1}' "$path")
    for value in "${first_column[@]}"; do
        rm -rf $value
    done
else
    echo "FAILURE"
fi
}