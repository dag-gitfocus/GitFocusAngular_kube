pipeline {
    environment {
    registry = "priya2802/gitfocus_service_kube"
    registryCredential = 'GITFocus-DockerHub'
    dockerImage = ''
  }
   agent any 
    
    stages {
        stage('Initialize'){
            steps {
                    nodejs('DAGNodeJS'){
                          sh 'npm install'
                          sh 'cp  index.d.ts ./node_modules/@types/chart.js'
                    }
            }
        }
        stage('Building Image') {
            steps {
                   script {
                            dockerImage = docker.build registry + ":$BUILD_NUMBER"
                            //dockerImage = docker.build registry + ":1.1"
                   }
            }           
        }              
    }
}
