#!/bin/bash

# Find podman-compose
PODMAN_COMPOSE_PATH=$(find / -name podman-compose 2>/dev/null | head -n 1)

# Extract directory from path
PODMAN_COMPOSE_DIR=$(dirname "$PODMAN_COMPOSE_PATH")

# Add directory to PATH in .bashrc if not already present
if ! grep -q "export PATH=\$PATH:$PODMAN_COMPOSE_DIR" ~/.bashrc ; then
    echo "export PATH=\$PATH:$PODMAN_COMPOSE_DIR" >> ~/.bashrc
    export PATH=$PATH:$PODMAN_COMPOSE_DIR
fi

# Reload .bashrc
source ~/.bashrc

# Verify installation
podman-compose --version