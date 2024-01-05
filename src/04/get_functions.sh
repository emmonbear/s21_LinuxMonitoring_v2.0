#!/bin/bash

# Сгенерировать случайное число между $1 и $2
# Parameters:
#   $1 - минимальное случайное число
#   $2 - максимальное случайное число
random () {
  local min=${1}
  local max=${2}
  local number

  number=$(shuf -i ${min}-${max} -n 1)
  readonly number

  echo "${number}"
}

# Сгенерировать случайный IP
get_IP () {
  local ip
  ip=$(random 0 255)

  for (( i = 0; i < 3; i++)); do
    ip+="."$(random 0 255)
  done
  
  readonly ip

  echo "$ip"
}

# Сгенерировать случайный код ответа
get_code () {
  local -r codes=(200 201 400 401 403 404 500 501 502 503)

  local index
  index=$(random 0 9)
  readonly index

  echo ${codes[${index}]}
}

