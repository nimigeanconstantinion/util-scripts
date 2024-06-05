set -e

echo "Starting installation of Podman and Podman Compose..."
echo "Updating package repository..."
sudo apt-get update
echo "Installing Podman..."
sudo apt-get install -y podman
if ! command -v podman &> /dev/null; then
    echo "Podman could not be installed. Exiting..."
    exit 1
fi
echo "Podman successfully installed."
echo "Installing Podman Compose..."
sudo apt-get install -y python3-pip
sudo pip3 install podman-compose
if ! command -v podman-compose &> /dev/null; then
    echo "Podman Compose could not be installed. Exiting..."
    exit 1
fi
echo "Podman Compose successfully installed."
echo "Installation complete. Podman and Podman Compose are now installed."