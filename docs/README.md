# vita

# 1 Задание

    - Создан hosts.ini и помещен в ./ansible/inventories/prod/hosts.ini
    (Также можно проверить "sh-keyscan -p SSH_PORT_SERVER -H SSH_HOST_SERVER >> ~/.ssh/known_hosts && ansible -i hosts.ini all -m ping")

    - Роль "copy" создана через команду "ansible-galaxy init roles/copy" и расписана таска ./ansible/roles/copy/tasks/main.yml, после чего подключена в основной playbook.yml

    - В таске использовал loop для копирования всех нужных файлов *.env

    - Можно использоваь with_items (loop более лаконичный по синтаксису, также не нужно писать with_fileglob и т.п., а сделать через query("fileglob") и т.п., можно переименовывать loop_control.loop_var и еще много функций)

    - дебажить можно с помощью debug, также через флаги в ansible-galaxy --syntax-check, --check --diff, --step

    - Запуск с помощью "nsible-playbook -i inventories/prod/hosts.ini playbook.yml -K" и добавлен сразу sudo ввод

# 2 Задание

    - добавить chmod +x ./bash/task.sh для выполнения запустить "./task.sh &> task.log" для вывода в файл task.log

# 3 Задание

    - Сеть назвал vita-network
    - Имя процесса vita
    - Использовал готовый образ php:7.4-fpm, healthcheck проверяю через то, запустился ли такой процесс в /proc/1/comm, можно пустить цикл по перебору, если он не под 1 PID
    - Тут скажу честно, я не понял что значит смонтировать "текущий" (какой текущий каталог?), я просто директорю "./www" и смонтировал ее в "/var/local/sandboxes/dev/www"
    - Также про передачу env переменной, я бы сразу в конфиге указал, но тут прописал явно как в задание через стандартный синтаксис
    - nginx в хост пустил на 1234, он слушает 80 порт в контейнере
    - сделал так, чтобы nginx запускался, только после удачного healthcheck php
    - и монтировал default.conf
    - процессы использует vita-networks
    - Также добавил образ postgres:15, в нем добавил volumes для безопасного хранения данных, чтобы они не слетели при остановки
        volumes:
      ./postgres/data:/var/lib/postgresql/data
    - Команда для запуска docker-compose up -d

# Ответы на вопросы

1. При изменение содержимого смонтированных каталогов будет меняется и в самом контейнере
2. Перезапуск контейнера при изменении default.conf не нужен
3. Если изменили сервисы в docker-compose.yml, то да, нужно пересобрать
4. Большее предпочтение к docker-compose, Так как с ним больше всего работал
    