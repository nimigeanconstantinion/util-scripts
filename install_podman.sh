#!/bin/bash

# Stop on any error
set -e

echo "Starting installation of Podman and Podman Compose..."

# Update the package repository
echo "Updating package repository..."
sudo dnf update -y

# Install Podman
echo "Installing Podman..."
sudo dnf install -y podman

# Verify Podman installation
if ! command -v podman &> /dev/null
then
    echo "Podman could not be installed. Exiting..."
    exit 1
fi

echo "Podman successfully installed."

# Install Podman Compose
echo "Installing Podman Compose..."
sudo dnf install -y podman-compose

# Verify Podman Compose installation
if ! command -v podman-compose &> /dev/null
then
    echo "Podman Compose could not be installed. Exiting..."
    exit 1
fi

echo "Podman Compose successfully installed."

echo "Installation complete. Podman and Podman Compose are now installed."