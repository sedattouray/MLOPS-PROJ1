pipeline{
    agent any

    environment{
        VENV_DIR = 'venv'
    }

    stages{
        stage('Cloning Github repo to Jenkins'){
            steps{
                script{
                echo 'BCloning Github repo to Jenkins.........'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/sedattouray/MLOPS-PROJ1.git']])
            }
       
            }

       stage('Setting up our Virtual Environment and installing dependencies'){
            steps{
                script{
                echo 'Setting up Virtual Environment and installing dependencie.........'
                sh '''python -m venv ${VENV_DIR}
                . ${VENV_DIR}/bin/activate
                pip install --upgrade pip
                pip install -e .'''
                
            }
       
            }
       
            }
        }  }
} 

