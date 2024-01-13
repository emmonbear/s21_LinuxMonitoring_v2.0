#!/bin/bash

install () {
  local distribution
  distribution=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  readonly distribution
  
  case ${distribution} in
    *"Ubuntu"* | *"Debian")
      sudo apt-get update
      sudo apt-get install -y goaccess
      ;;
    *"Fedora"*)
      yum install -y goaccess
      ;;
    *"Arch"*)
      pacman -S goaccess
      ;;
    *"Gentoo"*)
      emerge net-analyzer/goaccess
      ;;
    *)
      error_message "Дистрибутив не поддерживается"
      exit 1
      ;;
    esac
}
install