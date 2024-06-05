#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
podman container stop $(podman container ls -aq) 2>/dev/null

# Remove all containers
echo "Removing all containers..."
podman container rm $(podman container ls -aq) 2>/dev/null

# Remove all images
echo "Removing all images..."
podman rmi $(podman image ls -aq) 2>/dev/null

echo "Cleanup complete."