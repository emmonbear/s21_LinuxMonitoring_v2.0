#!/bin/bash

source ./validation.sh

validation $@
if [[ $? -eq 0 ]]; then
    source ./create.sh
    create_folders_and_files $@
else
    exit 1
fi
