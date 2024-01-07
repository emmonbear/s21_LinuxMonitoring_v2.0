# Part 7. Prometheus и Grafana

## Содержание

1. [Установка Prometheus](#1-установка-prometheus)


## 1. Установка Prometheus <br/>

* Обновить системные пакеты: <br/>
  ```sh
  $ sudo apt update
  ```
* Создать системного пользователя для `Prometheus`<br/>
  ```sh
  $ sudo groupadd --system prometheus
  $ sudo useradd -s /sbin/nologin --system -g prometheus prometheus
  ```
  Создание пользователя для `Prometheus` с ограниченными правами снижает риск несанкционнированного доступа.<br/>

* Создание каталогов для `Prometheus`<br/>
  Для хранения конфигурационных файлов и библиотек Prometheus необходимо создать несколько каталогов.
  ```sh
  $ sudo mkdir /etc/prometheus
  $ sudo mkdir /var/lib/prometheus
  ```

* Загрузить `Prometheus` и извлечь файлы<br/>
  ```sh
  $ wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz

  $ tar vxf prometheus*.tar.gz
  ```

* Перейти в каталог Prometheus<br/>
  ```sh
  $ cd prometheus*/
  ```
[Содержание](#содержание)


