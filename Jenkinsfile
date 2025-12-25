pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = "i-beaker-479319-a9"
        IMAGE_NAME = "hotel-reservation-prediction"
    }

    stages {

        stage('Cloning Github repo to Jenkins') {
            steps {
                echo 'Cloning Github repo to Jenkins...'
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

        stage('Setting up Virtual Environment and Installing Dependencies') {
            steps {
                echo 'Setting up virtual environment and installing dependencies...'
                sh '''
                    python3 -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                '''
            }
        }

        stage('Building and Pushing Docker Image to GCR') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    script {
                        // Use official Google Cloud SDK image to avoid missing gcloud errors
                        docker.image('google/cloud-sdk:latest').inside('--privileged') {
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

    }

    post {
        failure {
            echo 'Pipeline failed. Check logs for errors.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}
