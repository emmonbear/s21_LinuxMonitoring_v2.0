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
  local -r operating_systems=("Windows" "Macintosh" "Linux" "iOS" "Android")
  local -r versions=("5.0" "5.1" "5.3" "6.0" "6.1" "6.2" "7.0" "7.4" "8.0" "9.0" "9.1")
  local -r user_agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" \
          "Microsoft Edge" "Crawler and bot" "Library and net tool")
  
  local index

  local random_os
  index=$(random 0 4)
  random_os=${operating_systems[${index}]}
  readonly random_os

  local random_versions
  index=$(random 0 10)
  random_versions=${versions[${index}]}
  readonly random_versions
  
  local random_agents
  index=$(random 0 7)
  random_agents=${user_agents[${index}]}
  readonly random_agents

  echo "${random_agents}/${random_versions} (${random_os})"
}
get_user_agent

# Сгенерировать случайный URL
get_URL () {
  local length
  length=$(random 4 10)

  local URL

  local cnt
  cnt=$(random 2 6)
  readonly cnt

  local -r extensions=(".txt" ".mp4" ".pdf" ".sh" ".css" ".html" ".jpg" ".png" ".gif" ".jpeg" "")

  local index
  index=$(random 0 10)
  readonly index

  for (( i = 0; i < cnt; i++ )); do
    length=$(random 4 10)
    URL+="/"$(head -c 100 /dev/urandom | base64 | sed 's/[+=/A-Z]//g' | tail -c ${length})
  done

  URL+=${extensions[${index}]}
  readonly URL

  echo $URL
}

# Сгенерировать случайное время в формате (HH:MM:SS)
get_time () {
  local hour
  hour=$(random 0 23)
  if [[ ${hour} -lt 10 ]]; then
    hour="0"${hour}
  fi
  readonly hour
  
  local minute
  minute=$(random 0 59)
  if [[ ${minute} -lt 10 ]]; then
    minute="0"${minute}
  fi
  readonly minute

  local second
  second=$(random 0 59)
  if [[ ${second} -lt 10 ]]; then
    second="0"${second}
  fi
  readonly second

  local -r date="${hour}:${minute}:${second}"

  echo ${date}
}

# Генерация случайной даты в формате "12/Dec/2023":
get_date () {
  local current_date
  current_date=$(date "+%Y-%m-%d")
  readonly current_date

  local -r start_date="2023-01-01"
  
  local current_timestamp
  current_timestamp=$(date -d ${current_date} +%s)
  readonly current_timestamp

  local start_timestamp
  start_timestamp=$(date -d ${start_date} +%s)
  readonly start_timestamp

  local days_passed
  days_passed=$(( (current_timestamp - start_timestamp) / 86400 ))
  readonly days_passed

  local random_days
  random_days=$(random 1 ${days_passed})
  readonly random_days

  local random_date
  random_date=$(date -d "@$((start_timestamp + random_days * 86400))" "+%d/%b/%Y")
  readonly random_date

  echo ${random_date}
}

# Сгенерировать HTTP протокол
get_HTTP_protocol () {
  local -r protocols=("HTTP/0.9" "HTTP/1.0" "HTTP/1.1" "HTTP/2" "HTTP/3")

  local index
  index=$(random 0 4)
  readonly index

  echo ${protocols[${index}]}
}
