#!/bin/bash

source ./validation.sh

validation $@
if [[ $? -eq 0 ]]; then
    if [[ $1 -eq 1 ]]; then
        source ./first_way.sh
        first_way
    elif [[ $1 -eq 2 ]]; then
        source ./second_way.sh
        second_way
    else
        source ./third_way.sh
        third_way
    fi
else
    echo "FAILURE"
fi
