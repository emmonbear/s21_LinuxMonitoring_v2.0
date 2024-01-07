# Part 7. Prometheus и Grafana

## Содержание

1. [Установка Prometheus](#1-установка-prometheus)
2. [Настройка Prometheus](#2-настройка-prometheus)
3. [Установка Grafana](#3-установка-grafana)
4. [Настройка Grafana](#4-настройка-grafana)


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

  ![part_7](./screenshots/1.png)<br/>

[Содержание](#содержание)

## 2. Настройка Prometheus <br/>

* Переместить файлы и установить владельца:<br/>
  ```sh
  $ sudo mv prometheus /usr/local/bin
  $ sudo mv promtool /usr/local/bin
  $ sudo chown prometheus:prometheus /usr/local/bin/prometheus
  $ sudo chown prometheus:prometheus /usr/local/bin/promtool
  ```

* Переместить файлы конфигурации:<br/>
  ```sh
  $ sudo mv consoles /etc/prometheus
  $ sudo mv console_libraries /etc/prometheus
  $ sudo mv prometheus.yml /etc/prometheus
  ```

* Установить владельца:<br/>
  ```sh
  $ sudo chown prometheus:prometheus /etc/prometheus
  $ sudo chown -R prometheus:prometheus /etc/prometheus/consoles
  $ sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
  $ sudo chown -R prometheus:prometheus /var/lib/prometheus
  ```

* Настройка `Prometheus Systemd Service` для работы `Prometheus` в качестве службы:<br/>
  ```sh
  $ sudo vim /etc/systemd/system/prometheus.service
  ```

  ![part_7](./screenshots/2.png)<br/>

* Перезагрузить `systemd`<br/>
  ```sh
  $ sudo systemctl daemon-reload
  ```

* Запустить службу `Prometheus`<br/>
  ```sh
  $ sudo systemctl enable prometheus
  $ sudo systemctl start prometheus
  ```

* Проверить состояние `Prometheus`<br/>
  ```sh
  $ sudo systemctl status prometheus
  ```

  ![part_7](./screenshots/3.png)<br/>

* Проверить доступ к веб-интерфейсу `Prometheus`<br/>
  По умолчанию `Prometheus` работает на `порту 9090`, поэтому нужно разрешить `порт 9090` на брандмауэре:<br/>
  ```sh
  $ sudo ufw allow 9090/tcp
  ```

  ![part_7](./screenshots/4.png)<br/>

[Содержание](#содержание)

## 3. Установка Grafana <br/>

Перед следующими действиями необходимо включить VPN:<br/>

* Установить необходимые пакеты:<br/>
  ```sh
  $ sudo apt-get install -y apt-transport-https software-properties-common wget
  ```

* Импортировать ключ GPG:<br/>
  ```sh
  $ sudo mkdir -p /etc/apt/keyrings/

  $ wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
  ```

* Чтобы добавить репозиторий для стабильных релизов, выполнить команду:<br/>
  ```sh
  $ echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
  ```

* Чтобы добавить репозиторий для бета-версий, выполнить команду:<br/>
  ```sh
  $ echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
  ```

* Обновить список доступных пакетов:<br/>
  ```sh
  $ sudo apt-get update
  ```

* Установить `Grafana OSS`:<br/>
  ```sh
  $ sudo apt-get install grafana
  ```

* Установить `Grafana Enterprise`:<br/>
  ```sh
  $ sudo apt-get install grafana-enterprise
  ```

[Содержание](#содержание)

## 4. Настройка Grafana <br/>

* Запустить службу `Grafana`<br/>
  ```sh
  $ sudo systemctl start grafana-server
  ```

* Включить автозапуск `Grafana` при загрузке:<br/>
  ```sh
  $ sudo systemctl enable grafana-server
  ```

* Проверить статус `Grafana`:<br/>
  ```sh
  $ sudo systemctl status grafana-server
  ```

  ![part_7](./screenshots/5.png)<br/>

* Проверить доступ к веб-интерфейсу `Grafana`<br/>
  По умолчанию `Grafana` работает на `порту 3000`, поэтому нужно разрешить `порт 3000` на брандмауэре:<br/>
  ```sh
  $ sudo ufw allow 3000/tcp
  ```

  ![part_7](./screenshots/6.png)<br/>

* При первом запуске ввести логин: `admin` и пароль: `admin`. После этого можно сменить пароль<br/>

* Перейти `Connections`->`Data sources`->`Add data source`<br/>

  ![part_7](./screenshots/7.png)<br/>

* В открывшемся окне выбрать `Prometheus`<br/>

  ![part_7](./screenshots/8.png)<br/>

* В `Connection` указать URL `Prometheus` (по умолчанию: `http://localhost:9090`)

  ![part_7](./screenshots/9.png)<br/>

* Сохранить изменения `Save and Test`<br/>

[Содержание](#содержание)