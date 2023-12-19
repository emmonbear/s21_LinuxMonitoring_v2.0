#!/bin/bash

source ./validation.sh
start_time=$(date +%s)

validation $@
if [[ $? -eq 0 ]]; then
    source ./create.sh
    echo -e "\nВремя запуска скрипта: $(date +"%d.%m.%Y в %H:%M")" >> log.txt
    create_folders_and_files $@
else
    exit 1
fi

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "Скрипт выполнился за $execution_time секунд."