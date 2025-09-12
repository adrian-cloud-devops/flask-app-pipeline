#!/bin/bash
set -e  # end while failure
exec > /home/ec2-user/flask-todo-app/startup.log 2>&1  # log stdout and stderr

echo "=== Starting Flask App ==="
cd /home/ec2-user/flask-todo-app || { echo "Directory not found"; exit 1; }

echo "Installing requirements..."
pip3 install -r requirements.txt

echo "Killing old processes..."
pkill -f "python3 app.py" || true

echo "Launching app..."
nohup python3 app.py > app.log 2>&1 &

echo "Done. Check app.log for Flask output."
