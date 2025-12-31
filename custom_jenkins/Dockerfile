FROM jenkins/jenkins:lts

USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    curl \
    ca-certificates \
    gnupg \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK (non-interactive)
RUN curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts

ENV PATH="/root/google-cloud-sdk/bin:/usr/local/bin:/usr/bin:/bin"

# Fix Docker permissions (CRITICAL)
RUN groupadd -g 1 docker || true \
    && usermod -aG docker jenkins \
    && chmod 666 /var/run/docker.sock || true

USER jenkins
