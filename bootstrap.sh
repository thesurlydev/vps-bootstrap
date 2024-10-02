#!/bin/bash

# This script is use to bootstrap an Ubuntu 24.04 VPS.

set -e

function install_caddy() {
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    apt-get update
    apt-get install -y caddy
}

function expose_caddy() {
    curl -X POST 'http://localhost:2019/load' -H 'Content-Type: application/json' -d @caddy-config.json
}

function install_podman() {
    curl -fsSL -o podman-linux-amd64.tar.gz https://github.com/mgoltzsche/podman-static/releases/latest/download/podman-linux-amd64.tar.gz
    tar -xzf podman-linux-amd64.tar.gz
    cp -r podman-linux-amd64/usr podman-linux-amd64/etc /
}

function enable_podman_service() {
    cp podman-api.service /etc/systemd/system/podman-api.service
    systemctl daemon-reload
    systemctl enable --now podman-api.service
}


install_caddy
expose_caddy
install_podman
enable_podman_service

echo "Done!"
