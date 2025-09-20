#!/bin/bash
set -e

echo ">>> Installing Python and pip..."
sudo dnf install -y python3 python3-pip

echo ">>> Installing Python dependencies..."
cd /home/ec2-user/flask-todo-app 
pip3 install -r requirements.txt
