pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = 'i-beaker-479319-a9'
        IMAGE_NAME = 'gcr.io/i-beaker-479319-a9/hotel-project:latest'
    }

    stages {

        stage('Clone GitHub Repo') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        credentialsId: 'github-token',
                        url: 'https://github.com/sedattouray/MLOPS-PROJ1.git'
                    ]]
                )
            }
        }

        stage('Setup Python Virtual Environment') {
            steps {
                sh '''
                python3 -m venv ${VENV_DIR}
                . ${VENV_DIR}/bin/activate
                pip install --upgrade pip
                pip install -e .
                '''
            }
        }

        stage('Build & Push Docker Image to GCR') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                    gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                    gcloud config set project ${GCP_PROJECT}
                    gcloud auth configure-docker --quiet

                    docker build -t ${IMAGE_NAME} .
                    docker push ${IMAGE_NAME}
                    '''
                }
            }
        }

        stage('Deploy to Cloud Run') {
            steps {
                withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                    gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                    gcloud config set project ${GCP_PROJECT}

                    gcloud run deploy hotel-service \
                      --image ${IMAGE_NAME} \
                      --platform managed \
                      --region us-central1 \
                      --allow-unauthenticated
                    '''
                }
            }
        }
    }
}
