#!/bin/bash

source ./validation.sh
source ./create.sh

validation $@
if [[ $? -eq 0 ]]; then
    create_folders $1 $2 $3
else
    exit 1
fi
