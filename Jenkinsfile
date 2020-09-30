pipeline {
    environment {
    registry = "priya2802/gitfocus_service_kube"
    registryCredential = 'GITFocus-DockerHub'
    dockerImage = ''
  }
   agent any 
   tools { 
    maven 'maven 3.6.3'
   }
    stages {
        stage('Initialize'){
            steps {
                    nodejs('DAGNodeJS'){
                          sh 'npm install'
                          sh 'cp  index.d.ts ./node_modules/@types/chart.js'
                    }
            }
        }
        stage('Build') {
            steps {
                    nodejs('DAGNodeJS'){
                        sh 'npm run-script build'
                    }
            }
        }
	stage ("Code Analysis") {	   
            steps {	
		    script{
			    def scannerHome = tool 'DAGSonarQubeScanner'
		    }
	            withSonarQubeEnv('SonarQube') {	            
	            //sh "${scannerHome}/bin/sonar-scanner"
	            sh '${scannerHome}/bin/sonar-scanner'
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
        stage('Clean Up'){
            steps {
                sh 'rm -r src output  e2e'
                sh 'rm -f browserslist tsconfig.app.json README.md tsconfig.json angular.json  tsconfig.spec.json karma.conf.js  tslint.json index.d.ts'
            }
        }
        stage('Push to DockerHub') {
            steps{
                  script {
                            docker.withRegistry( '', registryCredential ) {
                            dockerImage.push()
                           }
                  }
             }
        }
    }
    post {
    always {
    	     cleanWs()        
	         emailext body:'''${DEFAULT_CONTENT}''',
                      recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                      subject:''' ${DEFAULT_SUBJECT}'''
    }
  }
}
