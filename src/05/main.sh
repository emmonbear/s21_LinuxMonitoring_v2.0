#!/bin/bash

main () {
  local -r method=${@}
  
  source ./sort.sh
  find_files

  case $method in
    1)
      first_method
      ;;
    2)
      second_method
      ;;
    3)
      third_method
      ;;
    4)
      fourth_method
      ;;
    *)
      error_message "Некорректный аргумент"
      exit 1
      ;;
    esac
}
main ${@}
