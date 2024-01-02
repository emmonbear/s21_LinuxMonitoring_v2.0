#!/bin/bash

# Сканирование каталога
# Parameters:
#   $1 - путь
scan () {
  local generated_names=()
  for entry in "$1"/*; do
    if [[ -e "$entry" ]]; then
      name=$(basename "$entry")
      name=${name%%_*}
      generated_names+=(${name})
    fi
  done
  
  echo ${generated_names[@]}
}

# Создать каталог
# Parameters:
#   $1 - список букв для каталогов
#   $2 - путь
# Returns:
#   0 - каталог создался
#   1 - каталог не создался
create_folders () {
  source ./generate_names.sh

  date=$(date +"%d%m%y")

  local -r list=$1
  local -r path=$2
  local name=""
  while true; do
    name=$(generate_name $list)
    if [[ ! " ${folder_check[@]} " =~ " ${name} " ]]; then
      folder_check+=($name)
      dest_folder="${path}/${name}_${date}"
      if mkdir "$dest_folder" 2>/dev/null; then
        echo "$dest_folder" >> log.txt
        return 0
      else
        return 1
      fi
    fi
  done
}

# Создать n файлов в dest_folder
# Parameters:
#   $1 - список букв для каталогов
#   $2 - расширение
#   $3 - размер
#   dest_folder - путь
# Returns:
#   0 - файлы создались
#   1 - в системе 1 Гб памяти или меньше. Генерация останавливается
create_files () {
  local -r list=$1
  local -r file_extension=$2
  local -r size=${3%?}
  local -r file_count=$(shuf -i 1-100 -n 1)
  local name=""
  local dest_file=""
  local arr=()

  local -r FULL_MEMORY=$(df / | grep /$ | awk '{print $2}')
  local -r ONE_GB=1048576

  source ./generate_names.sh
  for ((i=0; i<file_count;i++)); do
    while true; do
      name=$(generate_name $list)
      if [[ ! " ${arr[@]} " =~ " ${name} " ]]; then
        arr+=($name)
        dest_file=${dest_folder}/${name}_${date}
        if fallocate -l $size $dest_file 2>/dev/null; then
          echo "$dest_file $date ${size}b" >> log.txt

          local remaining_memory=$(df / | grep /$ | awk '{print $3}')

          source ./status_bar.sh
          status_bar ${remaining_memory} ${FULL_MEMORY}
        fi

        if [[ $(available_memory) -le ${ONE_GB} ]]; then
          echo "В системе остался 1 Гб памяти. Скрипт завершает работу"
          return 1
        fi
        break
      fi
    done
  done
}

# Создать рандомное количество файлов в рандомном количестве каталогов
# в случайной папке
# Parameters:
#   $1 - список букв для каталогов
#   $2 - список букв для файлов
#   $3 - размер файла
# Returns:
#   0 - успешное завершение программы, когда не выделяется память для файла
create () {
  local -r list_folder_symbols=$1
  local -r list_file_symbols=$(echo $2 | awk -F. '{print $1}')
  local -r file_extension=$(echo $2 | awk -F. '{print $2}')
  local -r size=$3
  
  local array_path=($(find / -type d  2>/dev/null | grep -Ev '/bin$|/sbin$'))
  
  while true; do
    local current_path=${array_path[$(shuf -i 0-$((${#array_path[@]}-1)) -n 1)]}
    local folder_count=$(shuf -i 1-100 -n 1)
    folder_check=($(scan ${current_path}))
    for ((i=0; i<$folder_count; i++)); do
      if ! create_folders "$list_folder_symbols" "$current_path"; then
        break
      elif ! create_files $list_file_symbols $file_extension $size; then
        delete_up
        return 0
      fi
    done
  done
}

# Проверить свободную память
available_memory () {
  echo "$(df / | grep /$ | awk '{print $4}')"
}
