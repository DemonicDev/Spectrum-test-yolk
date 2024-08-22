#!/bin/bash
# Switch to the container's working directory
cd /home/container

echo "Updating package list..."
apt-get update

echo "Creating directory..."
mkdir -p /tmp
