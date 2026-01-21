#!/usr/bin/env sh
set -e

echo "[1/5] updating package index"
sudo apt update

echo "[2/5] installing docker packages"
sudo apt install -y docker-compose-v2 docker.io docker-buildx

echo "[3/5] ensuring docker group exists"
sudo groupadd docker || true

echo "[4/5] adding user to docker group"
sudo usermod -aG docker "$(id -un)"

echo "[5/5] enabling and starting docker services"
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

echo "docker installation completed successfully"
echo "log out and log back in to use docker without sudo"