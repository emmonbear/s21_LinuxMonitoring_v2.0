#!/bin/bash

first_way () {
    source ./validation.sh
    
    local path=$@

    validation_first_way $path
    if [[ $? -eq 0 ]]; then
        source ./status_bar.sh

        local start=1
        local finish=$(wc -l < "$path")
        
        mapfile -t first_column < <(awk '{print $1}' "$path")
        
        process_status_bar $start $finish &
        local pid=$!
        for value in "${first_column[@]}"; do
            if ! rm -rf $value 2>/dev/null && ! rmdir $value 2>/dev/null; then
                echo -e "\n\n${RED}Ошибка${RESET}: Не удается очистить файловую систему"
                echo "Возможно требуется запустить скрипт с root правами"
                kill -SIGINT "$pid" ## попробовать без флага
                return 1
            fi
        done
        wait "$pid"
    fi
}
# qwer helps.txt 10Mb
# qwer_271223
