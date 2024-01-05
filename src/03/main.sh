#!/bin/bash
# trap 'echo "# $BASH_COMMAND";read' DEBUG

main () {
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
    dialog_chosen_way_3

    if [[ $? -eq 0 ]]; then
        third_way "$name_mask"
    fi
    ;;
  *)
    error_message "Неверный ввод. Пожалуйста, введите номер способа (1/2/3)"
    ;;
esac

  echo -e "${GREEN}${BOLD}====================================================================${RESET}"
}

main "$@"