FROM jenkins/jenkins:lts

USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    ca-certificates \
    gnupg \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK
RUN curl -fsSL https://sdk.cloud.google.com | bash

# Make gcloud available system-wide
ENV PATH="/root/google-cloud-sdk/bin:${PATH}"

# Allow Jenkins to use Docker
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins
