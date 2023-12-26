#!/bin/bash

second_way () {
    local start_time="$1"
    local finish_time="$2"
    local regex=$(regular "$start_time" "$finish_time")
    local result=($(find / -newermt "@$(time_per_sec "$start_time")" ! -newermt "@$(time_per_sec "$finish_time")" 2>/dev/null | grep -E "$regex"))
    local start=1
    local finish=$(( ${#result[@]} ))
    source ./status_bar.sh
    process_status_bar $start $finish &
    local pid=$!
    for path in ${result[@]}; do
        if ! rm -rf $path 2>/dev/null; then
            if ! rmdir $value 2>/dev/null; then
                echo -e "\n\n${RED}Ошибка${RESET}: Не удается очистить файловую систему"
                echo "Возможно требуется запустить скрипт с root правами"
                kill -SIGINT "$pid" ## попробовать без флага
                return 1
            fi
        fi
    done
    wait "$pid"

}

time_per_sec () {
    local time="$1"
    IFS=". :" read -a time_array <<< "$time"
    local time_sec="$(date +%s -d "${time_array[2]}-${time_array[1]}-${time_array[0]} ${time_array[3]}:${time_array[4]}")"
    echo "$time_sec"
}

regular () {
    local start=$(time_per_sec "$1")
    local finish=$(time_per_sec "$2")
    local current_seconds="$start"
    local str=""
    while [[ "$current_seconds" -le "$finish" ]]; do
        current_date=$(date -d "@$current_seconds" "+%d%m%y")
        str+=".*_$current_date.*|"
        current_seconds=$((current_seconds + 86400))
    done
    str="${str%?}"
    echo "$str"
}
# regular "27.12.23 01:32" "27.12.23 01:34"
# 27.12.23 01:39
# 27.12.23 01:46

