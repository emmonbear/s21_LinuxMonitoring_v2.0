#!/bin/bash

# Создать массивы уникальных имен, каталоги и файлы
# Parameters:
#   $1 - абсолютный путь
#   $2 - количество каталогов
#   $3 - список букв для каталогов
#   $4 - количество файлов в каталоге
#   $5 - список букв для файлов
#   $6 - размер файла
create () {
  path=$1
  if [[ "${path}" != */ ]]; then
    path="${path}/"
  fi
  readonly path
  readonly count_folders=$2
  readonly list_folder_symbols=$3
  readonly count_files=$4
  list_file_symbols=$(echo $5 | awk -F. '{print $1}')
  readonly list_file_symbols
  file_extension=$(echo $5 | awk -F. '{print $2}')
  readonly file_extension
  readonly size="${6%?}"

  array_foldernames=()
  array_filenames=()

  draw_text "Генерация массива уникальных имен каталогов:"
  source ./generate_names.sh
  generate_list_names "$count_folders" "$list_folder_symbols" array_foldernames

  delete_up
  delete_up

  draw_text "Генерация массива уникальных имен файлов:"
  generate_list_names "$count_files" "$list_file_symbols" array_filenames

  delete_up
  delete_up
  
  draw_text "Генерация файлов и каталогов:"
  create_folders_and_files

  delete_up
  delete_up
}

# Генерация каталогов и файлов
# Returns:
#   0 - успешное завершение программы
#   1 - завершение программы при требовании запуска скрипта sudo
#   1 - завершение программы при остатке в системе 1Гб или меньше свободной памяти
create_folders_and_files () {
  local cnt_folders=0
  local cnt_files=0

  local -r finish=$(( count_folders * count_files ))
  local current_iteration=0

  local -r date=$(date +"%d%m%y")
  
  for folder in "${array_foldernames[@]}"; do
    local dest_folder="${path}${folder}_${date}"
    if ! mkdir "$dest_folder" 2>/dev/null; then
        delete_up
        error_message "Невозможно создать каталог по пути ${path}. Требуются root права"
        dialog_end
        exit 1
    else
      echo "${dest_folder} $(date +"%d.%m.%Y %H:%M")"  >> log.txt
      ((cnt_folders++))
      for file in "${array_filenames[@]}"; do
        local dest_file="${path}${folder}_${date}/${file}_${date}.${file_extension}"
        fallocate -l $size "$dest_file"
        ((current_iteration++))
        status_bar ${current_iteration} ${finish}
        echo  "${dest_file} $(date +"%d.%m.%Y %H:%M") ${size}b" >> log.txt
        ((cnt_files++))
        if [[ $(available_memory) -le 1048576 ]]; then
          delete_up
          error_message "В системе остается менее 1 Гб свободного места. Создано $cnt_folders каталогов, $cnt_files файлов"
          dialog_end
          exit 1
        fi
      done
    fi
  done
  echo ""
}

# Объем свободной памяти
available_memory () {
    echo "$(df / | grep /$ | awk '{print $4}')"
}