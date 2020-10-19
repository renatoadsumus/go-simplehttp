#!/bin/bash

set -e


export TASK_VERSION=$(aws ecs register-task-definition --cli-input-json file://container-definitions.json | jq --raw-output '.taskDefinition.revision')

echo "Registered ECS Task Definition: " $TASK_VERSION
