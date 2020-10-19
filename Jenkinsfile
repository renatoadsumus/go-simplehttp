pipeline {  
 
 agent {
   label 'master'
 } 


 environment {

   //## PESOAL ###
   //TASK_FAMILY="td-simplehttp"
   //SERVICE_NAME="service-simlehttp" 
   //CLUSTER_NAME="ecs-ec2"

   //### SANDBOX ###
   TASK_FAMILY="td-showroom-nginx-bff"
   SERVICE_NAME="srv-showroom-nginx-bff" 
   CLUSTER_NAME="latam-ecs-sbx-cluster-ec2"

 }


  stages {
    stage('Unit Test'){
         steps{ 			

          echo "#####################################"
          echo "###   TEST             			###"
          echo "#####################################"

       }
    }

  stage('Quality Gate'){
    steps{ 			

       echo "#####################################"
       echo "###   Quality Gate       			###"
       echo "#####################################"

     }
   }

  stage('Build Imagem Docker'){
    steps{

      echo "#####################################"
      echo "###   BUILD             			###"
      echo "#####################################"

    }
  }

  stage('Upload Docker Registry'){
     steps{

      echo "#####################################"
      echo "###  DEPLOY ARTIFACORY PRODUCAO  ###"
      echo "#####################################"

    }
  }

  stage('ECS - Create New Revision and Deploy '){		 

    steps{

       echo "#####################################"
       echo "###  Create New Revision  ###"
       echo "#####################################"      
	   
	   sh(""" sed -i 's/ID_CONTA_AWS/${env.ID_CONTA_AWS}/' container-definitions.json """)
	   
       //sh(""" aws ecs register-task-definition --cli-input-json file://container-definitions.json --region us-east-1 	""")
       //sh(""" aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $TASK_FAMILY:$TASK_VERSION """)
       //sh (""" aws ecs update-service --cluster \"cluster-devops-latam\" --service \"home-service\" --force-new-deployment --region us-east-1 """)
       //sh(""" ./register_task_definition.sh \"$TASK_FAMILY=\"${TASK_FAMILY} \"$SERVICE_NAME=\"${SERVICE_NAME} \"$CLUSTER_NAME=\"${CLUSTER_NAME} """)
	   
	   sh(""" ./register_task_definition.sh ${CLUSTER_NAME} ${SERVICE_NAME} ${TASK_FAMILY}""")
    }            
  }	
}

post {
  always {
    echo "Eliminando conteúdo do workspace..."
    cleanWs()
   }
 }
}


