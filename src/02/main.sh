#!/bin/bash


source ./validation.sh
time_1=$(date +%s)
start_time=$(date +"%d.%m.%Y в %H:%M:%S")

validation $@
if [[ $? -eq 0 ]]; then
    source ./create.sh
    create $@
else
    exit 1
fi

time_2=$(date +%s)
end_time=$(date +"%d.%m.%Y в %H:%M:%S")
execution_time=$((time_2 - time_1))
echo "$start_time"
echo "$end_time"
echo "$execution_time"