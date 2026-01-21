#!/usr/bin/env sh
set -e

echo "installing docker using the official script"
curl -fsSL https://get.docker.com | sudo sh


sudo groupadd docker || true
sudo usermod -aG docker "$(id -un)"

newgrp docker

sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service

echo "verifying installation"
docker --version
docker compose version || true
