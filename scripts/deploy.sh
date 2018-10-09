#!/bin/sh

aws lambda create-function \
--region us-west-1 \
--function-name HelloFunction \
--zip-file fileb://./dist/deployment.zip \
--runtime go1.x \
--tracing-config Mode=Active \
--role arn:aws:iam::<account-id>:role/<role> \
--handler vehicle