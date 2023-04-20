#!/bin/bash

# Login to ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <your_account_id>.dkr.ecr.<region>.amazonaws.com

# Get the list of all image IDs in ECR
ecr_images=$(aws ecr list-images --repository-name <repo_name> --filter tagStatus=UNTAGGED --query 'imageIds[*]' --output json | jq '.[] | {imageDigest: .imageDigest, imageTag: .imageTag}')

# Delete the images
for img in $ecr_images; do
    img_digest=$(echo $img | jq -r '.imageDigest')
    img_tag=$(echo $img | jq -r '.imageTag')
    aws ecr batch-delete-image --repository-name <repo_name> --image-ids imageDigest=$img_digest,imageTag=$img_tag
