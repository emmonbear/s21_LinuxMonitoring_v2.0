#!/bin/bash

main () {
  source ./validation.sh
  validation ${@}
  if [[ $? -eq 0 ]]; then
    echo "success"
  else
    exit 1
  fi
}
main ${@}