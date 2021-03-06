#!/bin/bash

set -e


export TASK_VERSION=$(aws ecs register-task-definition --region us-east-1 --cli-input-json file://container-definitions.json | jq --raw-output '.taskDefinition.revision')

echo "Registered ECS Task Definition: " $TASK_VERSION

DEPLOYED_SERVICE=$(aws ecs update-service --region us-east-1 --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $TASK_FAMILY:$TASK_VERSION | jq --raw-output '.service.serviceName')

echo "Deployment of $DEPLOYED_SERVICE complete"
