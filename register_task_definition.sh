#!/bin/bash

set -e


export TASK_VERSION=$(aws ecs register-task-definition --region us-east-1 --cli-input-json file://container-definitions.json | jq --raw-output '.taskDefinition.revision')

echo "Registered ECS Task Definition: " $TASK_VERSION

export SERVICE_PARA_CLUSTER=$(aws ecs list-services --region us-east-1 --cluster $CLUSTER_NAME| jq --raw-output '.serviceArns')

echo "Registered ECS Task Definition: " $TASK_VERSION

sleep 3

if [[ "$SERVICE_PARA_CLUSTER" == "[]" ]]
then	
	sed -i 's/TD_VERSION/'$TASK_VERSION'/' servive-definitions.json
	sleep 5
	aws ecs create-service --region us-east-1 --cli-input-json file://servive-definitions.json
    echo "New Created Service: " $SERVICE_NAME 		
else    
    echo "Service Already Existing: " $SERVICE_NAME 	
	DEPLOYED_SERVICE=$(aws ecs update-service --region us-east-1 --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $TASK_FAMILY:$TASK_VERSION | jq --raw-output '.service.serviceName')
	echo "Deployment of $DEPLOYED_SERVICE complete"	
	echo "All Services Existing: " $SERVICE_PARA_CLUSTER
fi

