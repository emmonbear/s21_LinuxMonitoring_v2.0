#!/bin/bash

# Сформировать логи nginx в combined формате:
# "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\""
# %h - IP
# %l - логин пользователя
# %u - имя пользователя
# %t - временная метка [12/Dec/2012:12:12:12 -0500]
# \"%r\" - строка запроса
# %>s - код статуса ответа сервера
# %b - размер ответа в байтах
# \"%{Referer}i\" - URL
# \"%{User-agent}i\" - user-agent
main () {
  source ./get_functions.sh

  local cnt_entries
  local date
  local filename

  for file in {1..5}; do
    filename="access_${file}.log"
    > ${filename}
    date=$(get_date)
    cnt_entries=$(shuf -i 100-1000 -n 1)
    for (( i = 0; i < cnt_entries; i++)); do
      echo "$(get_IP) "-" "-" [${date}:$(get_time) $(date +%z)] \""$(get_method) $(get_URL) $(get_HTTP_protocol)"\" $(get_code) "-" \"$(get_site)\" \"$(get_user_agent)\"" >> ${filename}
    done
    sort -t' ' -k4,4 ${filename} -o ${filename}
  done

}
main ${@}
