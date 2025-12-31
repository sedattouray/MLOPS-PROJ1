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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud SDK (system-wide)
RUN curl -fsSL https://sdk.cloud.google.com | bash \
    && mv /root/google-cloud-sdk /usr/local/google-cloud-sdk \
    && ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

# Match Docker socket GID (host socket = GID 1)
RUN groupadd -g 1 docker || true \
    && usermod -aG docker jenkins

USER jenkins

ENV PATH="/usr/local/google-cloud-sdk/bin:${PATH}"
