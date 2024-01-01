#!/bin/bash

# Вывод статус-бара
# Parameters:
#   $1 - увеличивающееся значение (как правило счетчик)
#   $2 - конечное значение
status_bar () {
  local progress=$(((${1}*100/${2}*100)/100))
  local finish=$(((${progress}*4)/10))
  local unfinished=$((40-$finish))

  local fill=$(printf "%${finish}s")
  local empty=$(printf "%${unfinished}s")

  printf "\r${BOLD}Прогресс${RESET}: [${fill// /#}${empty// /-}] ${progress}%%"
}
