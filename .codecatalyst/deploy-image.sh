#!/bin/sh

set -e

if [ -z "$PUBLIC_ECR_REGISTRY" ]; then
    echo "Skipping image deployment...";
elif [[ "$PUBLIC_ECR_REGISTRY" = "public.ecr.aws/aws-solutions" ]]; then
    echo "Skipping image deployment...";
else
    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$PUBLIC_ECR_REGISTRY"
    
    cd deployment/ecr/distributed-load-testing-on-aws-load-tester
    
    docker build -t distributed-load-testing-on-aws-load-tester .
    docker tag distributed-load-testing-on-aws-load-tester:latest "$PUBLIC_ECR_REGISTRY:$publicImageTag"
    docker push "$PUBLIC_ECR_REGISTRY:$publicImageTag"
fi


