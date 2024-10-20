#!/bin/bash

# This script is use to bootstrap an Ubuntu 24.04 VPS.

set -e

function install_podman() {
    curl -fsSL -o podman-linux-amd64.tar.gz https://github.com/mgoltzsche/podman-static/releases/latest/download/podman-linux-amd64.tar.gz
    tar -xzf podman-linux-amd64.tar.gz
    cp -r podman-linux-amd64/usr podman-linux-amd64/etc /
}

function enable_podman_service() {
    cp services/podman/podman-api.service /etc/systemd/system/podman-api.service
    systemctl daemon-reload
    systemctl enable --now podman-api.service
}

function enable_podman_socket() {
    sudo systemctl enable --now podman.socket
}

install_podman
enable_podman_service
enable_podman_socket

echo "Done!"
