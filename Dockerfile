FROM debian:latest
WORKDIR /inc

# Setup base image deps
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-multilib \
    libncurses5-dev \
    libx11-dev \
    uuid-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*