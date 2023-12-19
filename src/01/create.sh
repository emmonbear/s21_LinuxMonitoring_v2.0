#!/bin/bash

create_folders_and_files () {
    local date=$(date +"%d%m%y")
    local path=$1
    local count_folders=$2
    local list_folder_symbols=$3
    local count_files=$4
    local list_file_symbols=$(echo $5 | awk -F. '{print $1}')
    local file_extension=$(echo $5 | awk -F. '{print $2}')
    local size="${6%?}"
    local array_foldernames=()
    local array_filenames=()

    source ./generate_names.sh
    
    array_foldernames=($(generate_list_names $count_folders $list_folder_symbols $path))

    array_filenames=($(generate_list_names $count_files $list_file_symbols $path))

    for folder in "${array_foldernames[@]}"; do
        mkdir "$path/${folder}_${date}"
        for file in "${array_filenames[@]}"; do
            fallocate -l $size ${path}/${folder}_${date}/${file}_${date}.${file_extension}
        done
    done 
}
