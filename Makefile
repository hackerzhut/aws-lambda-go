#! /usr/bin/make -f
include .env

.DEFAULT_GOAL := test

clean:
	@rm -rf dist
	@mkdir -p dist

build: clean
	$(call yellow, "# Building Golang Binary...")
	docker-compose run go

run:
	sam local start-api

generate-sns-event:
	$(call yellow, "# Generating SNS Event for Testing...")
	sam local generate-event sns notification > event.json

install:
	go get github.com/aws/aws-lambda-go/events
	go get github.com/aws/aws-lambda-go/lambda
	go get github.com/stretchr/testify/assert

test:
	go test ./... --cover

prepare-s3: ## Create an S3 bucket.
	aws s3api create-bucket \
		--bucket $(AWS_BUCKET_NAME) \
		--region $(AWS_REGION) \
		--create-bucket-configuration LocationConstraint=$(AWS_REGION)

package: prepare-s3 ## Creates deployment zip file, uploads to S3, updates template.
	@aws cloudformation package \
		--template-file template.yml \
		--s3-bucket $(AWS_BUCKET_NAME) \
		--region $(AWS_REGION) \
		--output-template-file package.yml

deploy: ## Deploys the stack. (Cloudformation CreateChangeSet, ExecuteChangeSet).
	@aws cloudformation deploy \
		--template-file package.yml \
		--region $(AWS_REGION) \
		--capabilities CAPABILITY_IAM \
		--stack-name $(AWS_STACK_NAME)

describe:
	@aws cloudformation describe-stacks \
		--region $(AWS_REGION) \
		--stack-name $(AWS_STACK_NAME) \

curl: ## Test the application via curl.
	curl https://$(API_ID).execute-api.$(AWS_REGION).amazonaws.com/Prod/test

delete: ## Deletes the whole stack.
	aws cloudformation delete-stack \
   	--stack-name $(stack-name)

define yellow
	@tput setaf 3
	@echo $1
	@tput sgr0
endef

outputs:
	@make describe | jq -r '.Stacks[0].Outputs'

url:
	@make describe | jq -r ".Stacks[0].Outputs[0].OutputValue" -j