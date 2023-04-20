#!/bin/bash

# Initialize the Terraform configuration
terraform init

# Create an ECR repository on AWS
terraform apply -target=aws_ecr_repository.my-flask-app

# Build the Docker image and push it to the ECR repository
docker build -t my-flask-app .
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.us-west-2.amazonaws.com
docker tag my-flask-app aws_account_id.dkr.ecr.us-west-2.amazonaws.com/my-flask-app:latest
docker push aws_account_id.dkr.ecr.us-west-2.amazonaws.com/my-flask-app:latest

# Deploy the app to EKS
terraform apply
