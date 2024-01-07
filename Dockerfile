# Docker-команда FROM указывает базовый образ контейнера
# Наш базовый образ - это Linux с предустановленным python-3.11-slim
FROM python:3.11-slim

# Установим переменную окружения
ENV APP_HOME /web_dz2

# Установим рабочую директорию внутри контейнера
WORKDIR $APP_HOME

# Установим зависимости внутри контейнера
COPY pyproject.toml $APP_HOME/pyproject.toml
COPY poetry.lock $APP_HOME/poetry.lock

RUN pip install poetry
RUN poetry config virtualenvs.create false && poetry install --only main

# Скопируем остальные файлы в рабочую директорию контейнера
COPY . .

# Обозначим порт где работает приложение внутри контейнера
EXPOSE 5000

# Запустим наше приложение внутри контейнера
CMD ["python", "main.py"]