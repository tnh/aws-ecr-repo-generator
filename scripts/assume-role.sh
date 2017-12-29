#!/bin/bash

if [[ -z "${ROLE_ARN}" ]] ; then
  exit
fi

set -ue

RESPONSE=$(aws sts assume-role --role-arn ${ROLE_ARN} --role-session-name deploy)

export AWS_ACCESS_KEY_ID=$(echo ${RESPONSE} | jq --raw-output .Credentials.AccessKeyId)
export AWS_SECRET_ACCESS_KEY=$(echo ${RESPONSE} | jq --raw-output .Credentials.SecretAccessKey)
export AWS_SESSION_TOKEN=$(echo ${RESPONSE} | jq --raw-output .Credentials.SessionToken)

set +ue
