#!/bin/bash

# Начало таймера
start_time=$(date +%s)

# 1. Поиск в /var/log php7.4
count=$(grep -r "php7.4" /var/log/ | wc -l)
echo "Количество строк: $count" &> ./bash/task.log

# Конец таймера
end_time=$(date +%s)

# Вычисление времени выполнения
duration=$((end_time - start_time))
echo "Время выполнения: $duration секунд"