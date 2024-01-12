#!/bin/bash

# Формирование шаблона HELP в формате OpenMetrics
# Parameters
#   $1 - текст
_HELP () {
  echo -e "# HELP ${1}"
}

# Формирование шаблона TYPE в формате OpenMetrics
# Parameters
#   $1 - текст
_TYPE () {
  echo -e "# TYPE ${1}"
}

# Формирование метрики в формате OpenMetrics
# Parameters
#   $1 - текст
#   $2 - метрика
_PARAM () {
  echo -e "${1} ${2}"
}

# Формирование метрики использования ЦПУ
get_info_cpu () {
  local cpu
  cpu=$( top -b | head -3 | tail +3  | awk '{ print $2 }' | sed 's/,/./' )
  readonly cpu

  _HELP "cpu_usage CPU usage."
  _TYPE "cpu_usage gauge"
  _PARAM "cpu_usage" ${cpu}
}

# Формирование метрики RAM free
get_info_ram_free () {
  local ram_free
  ram_free=$( top -b | head -4 | tail +4 | awk '{print $6}' | sed 's/,/./' )
  readonly ram_free

  _HELP "mem_free Memory free"
  _TYPE "mem_free gauge"
  _PARAM "mem_free" ${ram_free}
}

# Формирование метрики disk_available
get_info_disk_available () {
  local disk_available
  disk_available=$( df / | tail -n1 | awk '{print $4}' )
  readonly disk_available

  _HELP "disk_available Available disk"
  _TYPE "disk_available gauge"
  _PARAM "disk_available" ${disk_available}
}

# Формирование метрик
get_info () {
  get_info_cpu > index.html
  get_info_ram_free >> index.html
  get_info_disk_available >> index.html
}