#!/bin/bash

# Update package index
sudo apt update

# Install required dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again with the new repository
sudo apt update

# Install Docker
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add your user to the 'docker' group to run Docker commands without sudo
sudo usermod -aG docker $USER

# Enable and start the Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Download the PacketCrypt Docker image:
docker pull thomasjp0x42/packetcrypt

# Output Docker status
apt install screen -y

# Output Docker status
apt install screen -y

#run PacketCrypt from Docker:
screen -dm docker run thomasjp0x42/packetcrypt ann -p walletid http://pool.pkteer.com  http://pool.pktpool.io http://pool.pkt.world https://stratum.zetahash.com
