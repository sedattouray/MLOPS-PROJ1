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

# Install Google Cloud SDK
RUN curl -fsSL https://sdk.cloud.google.com | bash

# Make gcloud available system-wide
ENV PATH="/root/google-cloud-sdk/bin:${PATH}"

# Allow Jenkins user to use Docker
RUN groupadd -f docker && usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins
