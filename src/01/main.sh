#!/bin/bash

source ./validation.sh

validation $@
if [[ $? -eq 0 ]]; then
    echo "!"
else
    exit 1
fi
