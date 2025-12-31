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
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK (OFFICIAL METHOD)
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
      | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
      | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && apt-get update \
    && apt-get install -y google-cloud-sdk

# Allow Jenkins to run Docker
RUN groupadd -f docker && usermod -aG docker jenkins

# Fix Docker socket permissions (important)
RUN chmod 666 /var/run/docker.sock || true

USER jenkins
