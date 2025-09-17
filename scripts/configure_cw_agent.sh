#!/bin/bash
set -e

echo ">>> Installing CloudWatch Agent"

# Install agent if not installed
sudo dnf install -y amazon-cloudwatch-agent

# Copy config
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
sudo cp /home/ec2-user/flask-todo-app/config/cw-config.json /opt/aws/amazon-cloudwatch-agent/etc/config.json

# Start agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/config.json \
  -s
