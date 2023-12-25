#!/bin/bash

second_way () {
    echo "1"
}

time_per_sec () {
    local time="$1"
    IFS=". :" read -a time_array <<< "$time"
    local time_sec="$(date +%s -d "${time_array[2]}-${time_array[1]}-${time_array[0]} ${time_array[3]}:${time_array[4]}")"
    echo "$time_sec"
}
