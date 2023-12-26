#!/bin/bash
# trap 'echo "# $BASH_COMMAND";read' DEBUG

source ./validation.sh
source ./dialog.sh

dialog_hello
dialog_choice_way
case $way in
    1)
        source ./first_way.sh
        dialog_chosen_way_1
        first_way $log_path
        ;;
    2)
        source ./second_way.sh
        dialog_chosen_way_2
        
        if [[ $? -eq 0 ]]; then
            second_way "$start_time" "$end_time"
        fi
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