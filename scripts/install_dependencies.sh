#!/bin/bash
set -e

echo ">>> Installing Python and pip..."
sudo dnf install -y python3 python3-pip

echo ">>> Installing Python dependencies..."
pip3 install -r requirements.txt
