#!/bin/sh

set -e

echo "Starting Ansible Check in container..."

if [ -f /etc/redhat-release ]; then
    if grep 8 /etc/redhat-release; then
        # Install CentOS 8 packages from vault -- the original repos are no longer reachable after EOL
        sed -i 's|^mirrorlist=|#mirrorlist=|' /etc/yum.repos.d/CentOS-*.repo
        sed -i 's|^#baseurl=http://mirror.centos.org/\$contentdir/\$stream/|baseurl=https://vault.centos.org/8-stream/|' /etc/yum.repos.d/CentOS-*.repo
    fi
fi

PACKAGES="ansible git bash"
if ! command -v ansible > /dev/null 2>&1; then
    echo "Ansible not found. Attempting to install..."
    if command -v dnf > /dev/null 2>&1; then
        dnf install -y ansible-core git python3-rpm
    elif command -v yum > /dev/null 2>&1; then
        dnf install -y $PACKAGES
    elif command -v apt-get > /dev/null 2>&1; then
        apt-get update && apt-get install -y $PACKAGES
    elif command -v apk > /dev/null 2>&1; then
        apk add $PACKAGES
    elif command -v zypper > /dev/null 2>&1; then
        zypper install -y $PACKAGES python3
    else
        echo "Could not detect package manager. Please use an image with Ansible pre-installed."
        exit 1
    fi
fi

/bin/bash -c "/action/ansible-container.sh"
