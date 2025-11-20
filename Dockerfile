# Use the geospatial base image
FROM ghcr.io/osgeo/gdal:ubuntu-small-latest

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 1. Install system dependencies
# We upgrade pip to ensure we get the latest compatible wheels
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# 2. Install Python libraries
# CRITICAL CHANGE: Added '--break-system-packages' to bypass Ubuntu restrictions
RUN pip3 install --break-system-packages --no-cache-dir --upgrade pip && \
    pip3 install --break-system-packages --no-cache-dir -r requirements.txt
