#!/bin/bash

# Получить случайное число между $1 и $2
# Parameters:
#   $1 - минимальное случайное число
#   $2 - максимальное случайное число
random () {
  local min=${1}
  local max=${2}
  local number=0

  number=$(shuf -i ${min}-${max} -n 1)
  readonly number
  echo "${number}"
}
