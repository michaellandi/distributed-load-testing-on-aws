#!/bin/sh

set -e

if [ -z "$PUBLIC_ECR_REGISTRY" ]; then
    echo "public.ecr.aws/aws-solutions";
    return 0;
elif [[ "$PUBLIC_ECR_REGISTRY" = "public.ecr.aws/aws-solutions" ]]; then
    echo "public.ecr.aws/aws-solutions";
    return 0;
fi

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$PUBLIC_ECR_REGISTRY"

cd deployment/ecr/distributed-load-testing-on-aws-load-tester

docker build -t distributed-load-testing-on-aws-load-tester .
docker tag distributed-load-testing-on-aws-load-tester:latest "$PUBLIC_ECR_REGISTRY:latest"
docker push "$PUBLIC_ECR_REGISTRY:latest"
