#!/bin/bash

source ./validation.sh

validation $@
if [[ $? -eq 0 ]]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi
