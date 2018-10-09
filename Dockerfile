FROM alpine

ENV SAM_CLI_VERSION=0.6.0 \
    PYTHONUSERBASE=/usr/local

RUN apk update
RUN apk add --no-cache python-dev py-pip git bash gcc musl-dev && \
    pip install --upgrade pip && \
    pip install --user aws-sam-cli==${SAM_CLI_VERSION} awscli

WORKDIR /var/opt
COPY . /var/opt/

EXPOSE 3000