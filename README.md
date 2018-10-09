# AWS Lambda using golang

## Description
This repo illustrates a sample workflow for creating, deploying and testing AWS Lambda function locally using golang.

## Requirements
- [Dep](https://github.com/golang/dep)
- [Docker](https://docs.docker.com/engine/installation)
- [Docker Compose](https://docs.docker.com/compose/install/#install-compose)
- [AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
- [SAM Local CLI](https://github.com/awslabs/aws-sam-cli)

## Usage:

You can run `docker-compose up` or `sam local start-api` to run the app. 

Note: If you are running in windows, please make sure you are building the go binary targeting the right OS. If you use `docker-compose up` then you don't need to worry about it.

For deployment and more customization please use the `make` commands. 

Examples:

```shell

#---------- Installing AWS libraries ----------#
## Installs aws lambda and event libraries to $GOPATH
make install

#---------- Running Locally ----------#
make run

#---------- Testing ----------#
make test

#---------- Building ----------#
## Requires docker and docker-compose installed local
## Runs only the go build process using docker
make build
```

## License
MIT