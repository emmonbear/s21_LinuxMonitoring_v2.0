#!/bin/bash

# Сформировать уникальное имя
# Parameters:
#   $1 - список букв, используемых в имени
generate_name () {
  local name="$1"
  local name_length=0

  local -r cnt_symbols=${#name}
  local -r max_length=100
  local -r min_length=4

  local random_index
  local char
  local end_str
  if ((${cnt_symbols} < 4)); then
    name_length=$(shuf -i $min_length-$max_length -n 1)
  else
    name_length=$(shuf -i ${cnt_symbols}-${max_length} -n 1)
  fi
  for ((j=0; j<${name_length} - ${cnt_symbols}; j++)); do
    random_index=$((RANDOM % ${#name}))
    char=${name:$random_index:1}
    end_str=${name:$random_index}
    name=${name:0:$random_index}
    name=${name}${char}${end_str}
  done

  echo $name
}

# Сканировать каталог по пути $1 и занести в массив все имена
# Parameters:
#   $1 - путь
scan () {
  local generated_names=()
  local name=""

  for entry in "$1"/*; do
    if [[ -e "$entry" ]]; then
      name=$(basename "$entry")
      name=${name%%_*}
      generated_names+=(${name})
    fi
  done
  
  echo ${generated_names[@]}
}

# Генерация массива уникальных имен
# Parameters:
#   $1 - количество уникальных имен
#   $2 - список букв, используемых в имени
#   $3 - ссылка на массив, в который осуществляется запись
# Returns:
#   0 - успешное завершение программы
#   1 - завершение программы при невозможности создать $1 уникальных имен
generate_list_names () {
  local -r count="$1"
  local -r list="$2"
  local -n generated_array="$3"

  local -r max_retries=1000

  local generated_names=$(scan $path)
  
  for ((i=0; i<$count;i++)); do
    local retries=0
    while true; do
      if [[ $retries -eq $max_retries ]]; then
        echo ""
        source ./validation.sh
        delete_up
        delete_up
        error_message "Невозможно создать $count уникальных имен"
        dialog_end
        exit 1
      else
        local name=$(generate_name $list)
        if [[ ! " ${generated_names[@]} " =~ " ${name} " ]]; then
          generated_names+=($name)
          generated_array+=($name)
          break
        fi
        ((retries++))
      fi
    done

    source ./status_bar.sh
    if [[ ${count} -eq 1 ]]; then
      status_bar 1 1
    else
      status_bar ${i} $(( count - 1))
    fi
  done
  echo ""
}
