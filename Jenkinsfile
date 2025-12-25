pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = "i-beaker-479319-a9"
        IMAGE_NAME = "hotel-reservation-prediction"
    }

    stages {

        stage('Cloning Github repo') {
            steps {
                echo 'Cloning Github repo...'
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'github-token',
                        url: 'https://github.com/sedattouray/MLOPS-PROJ1.git'
                    ]]
                )
            }
        }

        stage('Setup Python Environment') {
            steps {
                echo 'Setting up Python virtual environment and installing dependencies...'
                sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                '''
            }
        }

        stage('Build and Push Docker Image to GCR') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    // Run gcloud commands inside official gcloud container
                    docker.image('google/cloud-sdk:latest').inside {
                        sh '''
                            gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                            gcloud config set project ${GCP_PROJECT}
                            gcloud auth configure-docker --quiet

                            docker build -t gcr.io/${GCP_PROJECT}/${IMAGE_NAME}:latest .
                            docker push gcr.io/${GCP_PROJECT}/${IMAGE_NAME}:latest
                        '''
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for errors.'
        }
    }
}
