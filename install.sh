#!/bin/bash
# Switch to the container's working directory
cd /home/container

echo "Updating package list..."
apt-get update

echo "Creating directory..."
mkdir -p /tmp

echo "Setting permissions for /tmp..."
chmod 1777 /tmp  # Ensure /tmp has the right permissions (world-writable, sticky bit)
