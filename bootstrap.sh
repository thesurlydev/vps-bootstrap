#!/bin/bash

# This script is use to bootstrap an Ubuntu 24.04 VPS.

set -e

VOLUME_1="0HC_Volume_101503771"

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

function mount_volume_1() {
  mkdir /mnt/volume-1
  mount -o discard,defaults /dev/disk/by-id/scsi-${VOLUME_1} /mnt/volume-1
  echo "/dev/disk/by-id/scsi-${VOLUME_1} /mnt/volume-1 ext4 discard,nofail,defaults 0 0" >> /etc/fstab
}

install_podman
enable_podman_service
enable_podman_socket
mount_volume_1

echo "Done!"
