#!/bin/bash
# trap 'echo "# $BASH_COMMAND";read' DEBUG

source ./validation.sh
source ./greetings.sh
hello
echo -e -n "\n${BOLD}Введите номер способа (1/2/3): "
read way
if [[ $way =~ ^[1-3]$ ]]; then
    echo -e "${UP}${DELETE}Выбран способ: ${YELLOW}$way${RESET}\n"
else
    echo -e "${UP}${DELETE}${UP}"
fi
case $way in
    1)
        source ./first_way.sh
        echo -e -n "Введите путь к лог файлу: "
        read log_path
        if [[ -z $log_path ]]; then
            log_path="../02/log.txt"
        fi
        echo -e "${UP}${DELETE}${BOLD}Выбран файл: ${YELLOW}${log_path}${RESET}\n"
        first_way $log_path
        ;;
    2)
        source ./second_way.sh
        echo -e -n "Введите дату и время создания: "
        read creation_time
        second_way $creation_time
        ;;
    3)
        source ./third_way.sh
        echo -e -n "Введите маску имени: "
        read name_mask
        third_way $name_mask
        ;;
    *)
        echo -e "${RED}Ошибка${RESET}: Неверный ввод. Пожалуйста, введите число (${YELLOW}1${RESET}/${YELLOW}2${RESET}/${YELLOW}3${RESET})"
        ;;
esac

    echo -e "${GREEN}${BOLD}====================================================================${RESET}"