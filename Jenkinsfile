pipeline{
    agent any

    stages{
        stage('Cloning Github repo to Jenkins'){
            steps{
                script{
                echo 'BCloning Github repo to Jenkins.........'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sedattouray/MLOPS-PROJ1.git']])
            }
       
            }
        }
    }   
}