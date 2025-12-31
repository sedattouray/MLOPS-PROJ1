FROM jenkins/jenkins:lts

USER root

# Install deps
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    ca-certificates \
    gnupg \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Create docker group with HOST GID (IMPORTANT)
ARG DOCKER_GID=1
RUN groupadd -g ${DOCKER_GID} docker || true \
 && usermod -aG docker jenkins

# Install Google Cloud SDK (correct way)
RUN curl -sSL https://sdk.cloud.google.com | bash

# Make gcloud available to ALL users
ENV PATH="/root/google-cloud-sdk/bin:/usr/local/bin:/usr/bin:/bin"

USER jenkins
