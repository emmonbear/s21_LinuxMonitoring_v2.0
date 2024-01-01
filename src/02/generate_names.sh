#!/bin/bash

# Сгенерировать уникальное имя
# Parameters:
#   $1 - список букв
generate_name () {
  local name=$1
  local name_length=0

  local -r max_length=100
  local -r min_length=5
  local -r cnt_symbols=${#name}

  local random_index
  local char
  local end_str

  if ((${cnt_symbols} < ${min_length})); then
    name_length=$(shuf -i ${min_length}-${max_length} -n 1)
  else
    name_length=$(shuf -i ${cnt_symbols}-${max_length} -n 1)
  fi

  for ((i=0; i<${name_length} - ${cnt_symbols}; i++)); do
    random_index=$((RANDOM % ${#name}))
    char=${name:$random_index:1}
    end_str=${name:$random_index}
    name=${name:0:$random_index}
    name=${name}${char}${end_str}
  done

  echo $name
}
