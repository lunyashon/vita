# vita

## 1 Задание

- Создан `hosts.ini` и помещен в `./ansible/inventories/prod/hosts.ini`.
- Также можно проверить подключение:
```bash
ssh-keyscan -p <SSH_PORT_SERVER> -H <SSH_HOST_SERVER> >> ~/.ssh/known_hosts && ansible -i hosts.ini all -m ping
```
- Роль "copy" создана командой:
```bash
ansible-galaxy init roles/copy
```
  Таска описана в `./ansible/roles/copy/tasks/main.yml` и подключена в основной `playbook.yml`.
- В таске использован `loop` для копирования всех нужных файлов `*.env`.
- Можно использовать `with_items` (у `loop` более лаконичный синтаксис; можно делать через `query("fileglob")`, переименовывать `loop_control.loop_var` и др.).
- Дебажить можно модулем `debug`, а также флагами запуска:
```bash
ansible-playbook --syntax-check
ansible-playbook -i inventories/prod/hosts.ini playbook.yml --check --diff --step
```
- Запуск:
```bash
ansible-playbook -i inventories/prod/hosts.ini playbook.yml -K
```

## 2 Задание

- Сделать исполняемым:
```bash
chmod +x ./bash/task.sh
```
- Выполнить и вывести в `task.log`:
```bash
./task.sh &> task.log
```

## 3 Задание

- Сеть назвал:
```text
vita-network
```
- Имя процесса:
```text
vita
```
- Использован образ `php:7.4-fpm`. Healthcheck проверяет, что процесс запустился (через `/proc/1/comm`; при необходимости можно перебрать процессы).
- Смонтирована директория `./www` в `/var/local/sandboxes/dev/www`.
- Переменные окружения можно задавать в compose; для параметра `listen` удобнее прописать в конфиге.
- Nginx на хосте слушает порт `1234`, в контейнере — `80`.
- Сделано так, чтобы nginx запускался только после успешного healthcheck PHP; смонтирован `default.conf`.
- Сервисы используют сеть:
```text
vita-network
```
- Также добавлен образ `postgres:15`; для безопасного хранения данных примонтирован volume:
```yaml
volumes:
  - ./postgres/data:/var/lib/postgresql/data
```
- Команда для запуска:
```bash
docker compose up -d
```

## Ответы на вопросы

1. При изменении содержимого смонтированных каталогов изменения видны в контейнере.
2. Перезапуск контейнера при изменении `default.conf` не нужен.
3. Если изменили сервисы в `docker-compose.yml`, то да — нужно пересоздать/пересобрать.
4. Большее предпочтение к `docker-compose`, так как с ним больше всего работал.
