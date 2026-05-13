#!/bin/sh

set -e

echo "Starting Ansible Check in container..."

# 1. Ensure Ansible is installed (since images are dynamic, you might need a fallback)
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
        zypper install -y $PACKAGES
    else
        echo "Could not detect package manager. Please use an image with Ansible pre-installed."
        exit 1
    fi
fi

/bin/bash -c "/action/ansible-container.sh"
