#!/bin/bash

source ./validation.sh

if [[ $# == 6 ]]; then
    validation $@
else
    echo "incorrect"
fi
