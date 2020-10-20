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

parameters {
		
    string(defaultValue: "deploy", description: 'Informar Nova Task Definition ou Force da ultima', name: 'GIT_LAST_COMMIT_MESSAGE')    
	
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

    /when {
	   anyOf {
           environment name: 'gitlabSourceBranch', value: 'master';
           expression { return env.GIT_LAST_COMMIT_MESSAGE.contains("(deploy)") }
        }
    }*/

    steps{

       echo "##################################################"
       echo "###  Create New Task Definition and Deploy ECS ###"
       echo "##################################################"      
	   
	   if (env.GIT_LAST_COMMIT_MESSAGE == 'deploy') {	
	   	   
	     sh(""" sed -i 's/ID_CONTA_AWS/${env.ID_CONTA_AWS}/' container-definitions.json """)  
	   
	     sh(""" ./register_task_definition.sh ${CLUSTER_NAME} ${SERVICE_NAME} ${TASK_FAMILY}""")	   
	   
	   }	   
    }
  }	

  stage('ECS - Deploy Same Task Definition'){		 

  
    steps{
	
        if (env.GIT_LAST_COMMIT_MESSAGE == 'FORCE') {
	  
	      sh(""" aws ecs update-service --cluster \"${CLUSTER_NAME}\" --service \"${SERVICE_NAME}\" --force-new-deployment --region us-east-1 """)  
	   
	    }

       echo "##################################################"
       echo "###  Force Deploy Same Task Definition         ###"
       echo "##################################################"	  
	  
	   sh(""" aws ecs list-task-definitions --region us-east-1 """) 	  
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


