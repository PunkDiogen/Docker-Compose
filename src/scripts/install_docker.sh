#!/bin/bash
set -e

apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt update
apt-cache policy docker-ce
apt install -y \
  docker-ce \
  containerd.io \
  docker-compose-plugin

usermod -aG docker vagrant

systemctl enable docker
systemctl start docker
