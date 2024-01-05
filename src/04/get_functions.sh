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
# Коды:
# 200 - OK: успешный запрос
# 201 - Created: Ресурс успешно создан
# 400 - Bad Request: Неверный запрос
# 401 - Unauthorized: Неавторизованный запрос
# 403 - Forbidden: Доступ запрещен
# 404 - Not Found: Ресурс не найден
# 500 - Internal Server Error: Внутренняя ошибка сервера
# 501 - Not Implemented: Не реализовано
# 502 - Bad Gateway: Плохой шлюз
# 503 - Service Unavailable: Сервис недоступен
get_code () {
  local -r codes=(200 201 400 401 403 404 500 501 502 503)

  local index
  index=$(random 0 9)
  readonly index

  echo ${codes[${index}]}
}

# Сгенерировать случайный метод
get_method () {
  local -r methods=("GET" "POST" "PUT" "PATCH" "DELETE")

  local index
  index=$(random 0 4)
  readonly index

  echo ${methods[${index}]}
}

# Сгенерировать случайный UA
get_user_agent () {
  local -r user_agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" \
          "Microsoft Edge" "Crawler and bot" "Library and net tool")
  
  local index
  index=$(random 0 6)
  readonly index

  echo ${user_agents[${index}]}
}

