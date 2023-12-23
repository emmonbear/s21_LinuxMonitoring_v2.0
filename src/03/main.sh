#!/bin/bash
# trap 'echo "# $BASH_COMMAND";read' DEBUG

source ./validation.sh
source ./greetings.sh

hello
read -p "Введите номер способа (1/2/3): " choice
case $choice in
    1)
        read -p "Введите путь к лог файлу: " log_path
        source ./first_way.sh
        first_way $log_path
        ;;
    2)
        read -p "Введите дату и время создания: " creation_time
        source ./second_way.sh
        second_way $creation_time
        ;;
    3)
        read -p "Введите маску имени: " name_mask
        source ./third_way.sh
        third_way $name_mask
        ;;
    *)
        echo "Неверный выбор. Пожалуйста, введите число от 1 до 3."
        ;;
esac