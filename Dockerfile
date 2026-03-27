# Используем легковесный образ Ubuntu
FROM ubuntu:24.04

# Указываем метаданные
LABEL maintainer="International Group of Developers"
LABEL project="TOTAL Protocol"

# Установка системных зависимостей (без лишнего мусора)
RUN apt-get update && apt-get install -y \
    build-essential \
    verilator \
    git \
    && rm -rf /var/lib/apt/lists/*

# Создаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта в контейнер
COPY . .

# Компилируем ядро прямо при сборке образа
RUN verilator --binary -j 2 sentinel_challenge_v82.sv tb_sentinel_v82.sv --top-module tb_sentinel

# Команда по умолчанию при запуске контейнера
CMD ["./obj_dir/Vtb_sentinel"]
