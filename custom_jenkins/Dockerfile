# Switch to root user to install dependencies
USER root

# Install prerequisites, Docker, and Python
RUN apt-get update -y && \
    apt-get install -y ca-certificates curl gnupg lsb-release \
    python3 python3-venv python3-pip && \
    # Add Docker GPG key (signed-by method)
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    # Add Docker repository
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bullseye stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

