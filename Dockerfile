
FROM python:3.11-slim

# Prevent Python from writing .pyc files & unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy project code
COPY . .

# Install Python dependencies in editable mode
RUN pip install --no-cache-dir -e .

# Pre-train model if needed
RUN python pipeline/training_pipeline.py

EXPOSE 5000

CMD ["python", "application.py"]


