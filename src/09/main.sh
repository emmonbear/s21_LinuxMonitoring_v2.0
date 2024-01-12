#!/bin/bash

main () {
  source ./get_info.sh
  while true; do
    get_info
    sleep 3
  done
}
main ${@}