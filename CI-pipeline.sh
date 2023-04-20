#!/bin/bash

# Initialize the Terraform configuration
terraform init

# Create a GitHub Actions workflow for development environment
terraform apply -target=github_actions_workflow.development

# Create a GitHub Actions workflow for production environment
terraform apply -target=github_actions_workflow.production

# Deploy the app to development environment
terraform apply -target=aws_ecs_task_definition.my-flask-app-development
terraform apply -target=aws_ecs_service.my-flask-app-development

# Deploy the app to production environment
terraform apply -target=aws_ecs_task_definition.my-flask-app-production
terraform apply -target=aws_ecs_service.my-flask-app-production

