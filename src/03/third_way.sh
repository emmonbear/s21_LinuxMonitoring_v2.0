#!/bin/bash

third_way () {
    local mask="$1"
    IFS="_" read alphabet date <<< "$mask"
    local regex=$(regular "$alphabet" "$date")
    local result=($(find / 2>/dev/null | grep -E "$regex"))

    local start=1
    local finish=$(( ${#result[@]} ))
    source ./status_bar.sh
    process_status_bar $start $finish &
    local pid=$!
    for path in ${result[@]}; do
        if ! rm -rf $path 2>/dev/null && ! rmdir $path 2>/dev/null; then
            echo -e "\n\n${RED}Ошибка${RESET}: Не удается очистить файловую систему"
            echo "Возможно требуется запустить скрипт с root правами"
            kill -SIGINT "$pid" ## попробовать без флага
            return 1
        fi
    done
    wait "$pid"
}

regular () {
    local alphabet="$1"
    local date="$2"
    local result=""
    for ((i=0; i<${#alphabet}; i++)); do
        result+=".*${alphabet:i:1}"
    done
    result+=".*_${date}.*"
    echo "$result"
}
# asdf_271223