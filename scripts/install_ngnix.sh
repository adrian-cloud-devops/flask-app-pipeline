#!/bin/bash
set -e

echo ">>> Installing and configuring Nginx..."

# Install Nginx (AL2023 uses nginx1 package)
sudo dnf install -y nginx1

# Enable Nginx
sudo systemctl enable nginx

# Make sure conf.d exists
sudo mkdir -p /etc/nginx/conf.d

# Copy config
sudo cp /home/ec2-user/flask-todo-app/nginx/flask.conf /etc/nginx/conf.d/

# Remove default config if exists
sudo rm -f /etc/nginx/conf.d/default.conf || true

# Test config
sudo nginx -t

# Restart
sudo systemctl restart nginx

echo ">>> Nginx installed and restarted"
