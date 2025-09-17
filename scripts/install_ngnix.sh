#!/bin/bash
set -e

echo ">>> Installing and configuring Nginx..."

# Install Nginx if not installed
sudo dnf install -y nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Copy our app-specific config
sudo cp /home/ec2-user/flask-todo-app/nginx/flask.conf /etc/nginx/conf.d/

# Remove default config if exists
sudo rm -f /etc/nginx/conf.d/default.conf || true

# Test config before restart
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx

echo ">>> Nginx installed and restarted"