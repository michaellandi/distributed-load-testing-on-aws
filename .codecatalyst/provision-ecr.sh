#!/bin/sh

set -e

if [ -z "$publicEcrRegistry" ]; then
    echo "public.ecr.aws/aws-solutions";
fi

resp=$(aws ecr-public describe-repositories --region us-east-1 --query "repositories[?repositoryName==\`${publicEcrRegistry}\`] | [0].repositoryName" | jq --raw-output);

if [[ "$resp" = "null" ]]; then
    registry=$(aws ecr-public create-repository --repository-name $publicEcrRegistry --region us-east-1 | jq --raw-output .repository.repositoryUri)
    echo $registry;
else
    echo $resp;
fi