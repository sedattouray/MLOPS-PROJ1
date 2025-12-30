# Base Jenkins image
FROM jenkins/jenkins:lts

# Switch to root to install dependencies
USER root

# Install system dependencies, Python, Docker, and GCloud SDK
RUN apt-get update -y && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    docker.io \
    git \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK as root
USER root
RUN curl -fsSL https://sdk.cloud.google.com | bash

# Make gcloud executable available to all users
ENV PATH="/root/google-cloud-sdk/bin:${PATH}"
RUN chmod -R a+rx /root/google-cloud-sdk

# Switch back to Jenkins user
USER jenkins
