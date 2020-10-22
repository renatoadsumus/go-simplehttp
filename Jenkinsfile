pipeline {  
 
 agent {
   label 'master'
 } 


 environment { 

   //### SANDBOX ###
   TASK_FAMILY="td-showroom-nginx-bff"
   SERVICE_NAME="srv-showroom-nginx-bff" 
   CLUSTER_NAME="latam-ecs-sbx-cluster-ec2"  
   CLUSTER_REGION="us-east-1"

 }

parameters {
		
    string(defaultValue: "deploy", description: 'Informar a palavra deploy para Criar New Revision ou force para New Force Deploy', name: 'GIT_LAST_COMMIT_MESSAGE')    
	
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
      echo "###  DEPLOY DOCKER REGISTRY       ###"
      echo "#####################################"

    }
  }

  stage('ECS - Deploy New Task Definition'){	

    /*when {
	   anyOf {
           environment name: 'gitlabSourceBranch', value: 'master';
           expression { return env.GIT_LAST_COMMIT_MESSAGE.contains("(deploy)") }
        }
    }*/

    steps{            
	   
	   script {
	   
	        if (env.GIT_LAST_COMMIT_MESSAGE == 'deploy') {	
			
			   echo "##################################################"
               echo "###  Create New Task Definition and Deploy ECS ###"
               echo "##################################################"   
						   
			   
	           sh(""" sed -i 's/ID_CONTA_AWS/${env.ID_CONTA_AWS}/' task-definition.json """)  
	   
	           sh(""" ./deploy_ecs_ec2.sh ${CLUSTER_NAME} ${SERVICE_NAME} ${TASK_FAMILY}""")	   
	   
	        }
        }

		sh(""" aws ecs list-task-definitions --region ${CLUSTER_REGION} """) 	
    }
  }	

  stage('ECS - Deploy Same Task Definition'){		 

  
    steps{
	
        script {
		
		    if (env.GIT_LAST_COMMIT_MESSAGE != 'deploy') {
	  
	           sh(""" aws ecs update-service --cluster \"${CLUSTER_NAME}\" --service \"${SERVICE_NAME}\" --force-new-deployment --region ${CLUSTER_REGION} """)  
			   
			   echo "##################################################"
               echo "###  Force Deploy Same Task Definition         ###"
               echo "##################################################"
	   
	        }
        }       	  
	  
	   sh(""" aws ecs list-task-definitions --region ${CLUSTER_REGION} """) 	  
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


