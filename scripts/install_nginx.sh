#!/bin/bash
set -e

echo ">>> Installing and configuring Nginx..."

# Install Nginx 
sudo dnf install -y nginx

# Enable Nginx
sudo systemctl enable nginx

# Make sure conf.d exists
sudo mkdir -p /etc/nginx/conf.d

# Copy config
if [ -f /home/ec2-user/flask-todo-app/nginx/flask.conf ]; then
  sudo cp /home/ec2-user/flask-todo-app/nginx/flask.conf /etc/nginx/conf.d/
else
  echo "flask.conf not found!"
  exit 1
fi

# Remove default config if exists
sudo rm -f /etc/nginx/conf.d/default.conf || true

# Test config
sudo nginx -t

# Restart
sudo systemctl restart nginx

echo ">>> Nginx installed and restarted"
