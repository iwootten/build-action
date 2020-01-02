FROM python:3.8-slim-buster

RUN apt-get update && apt-get install -y \
    git \
    make \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --branch v0.13.0 --depth 1 https://github.com/google/jsonnet.git /tmp/jsonnet \
    && make -C /tmp/jsonnet \
    && cp /tmp/jsonnet/jsonnet /usr/local/bin \
    && rm -rf /tmp/jsonnet

COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock

RUN pip install pipenv==2018.11.26 --no-cache-dir \
    && pipenv install --deploy