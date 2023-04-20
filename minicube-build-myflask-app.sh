#!/bin/bash

# Start Minikube
minikube start --vm-driver=docker

# Set the Docker environment variables to use the Minikube Docker daemon
eval $(minikube docker-env)

# Build your custom Docker image
docker build -t my-flask-app.

# Deploy the image to the Minikube cluster
kubectl create deployment my-custom-deployment --image=my-flask-app

# Expose the deployment as a service
kubectl expose deployment my-custom-deployment --port=80 --target-port=80 --type=NodePort

# Get the URL of the service
minikube service my-custom-deployment --url
