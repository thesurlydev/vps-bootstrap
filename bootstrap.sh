#!/bin/bash

# This script is use to bootstrap an Ubuntu 24.04 VPS.

set -e

function log() {
  msg=$1
  logger -t bootstrap.sh "$msg"
}

function install_podman() {
    log "Installing podman..."
    curl -fsSL -o podman-linux-amd64.tar.gz https://github.com/mgoltzsche/podman-static/releases/latest/download/podman-linux-amd64.tar.gz
    tar -xzf podman-linux-amd64.tar.gz
    cp -r podman-linux-amd64/usr podman-linux-amd64/etc /
    log "Podman install complete"
}

function enable_podman_service() {
    log "Enabling podman service..."
    cp services/podman/podman-api.service /etc/systemd/system/podman-api.service
    systemctl daemon-reload
    systemctl enable --now podman-api.service
    log "Podman service enabled"
}

function enable_podman_socket() {
    log "Enabling Podman socket..."
    systemctl enable --now podman.socket
    log "Podman socket enabled"
}

function restart_now() {
    log "Restarting..."
    reboot --force
}

install_podman
enable_podman_service
enable_podman_socket
restart_now
