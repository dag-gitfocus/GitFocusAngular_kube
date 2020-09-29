pipeline {
    agent {
        docker { image 'node:10-alpine' }
    }
    stages {
        stage('Restore') {
            steps {
                sh 'npm install'
                sh 'cp  index.d.ts ./node_modules/@types/chart.js'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run-script build'
            }
        }
       /* stage('Test') {
            steps {
                sh 'ng run-script test'
            }
        }        
        stage('Deploy') {
            steps {
                sh 'rm ../../apps/*'
                sh 'cp ./dist/apps/* ../../apps/'
            }
        } */            
    }
}
