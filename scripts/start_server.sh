#!/bin/bash
cd /home/ec2-user/flask-todo-app
echo "Installing dependencies..."
pip3 install -r requirements.txt
echo "Starting Flask app..."
nohup python3 app.py > app.log 2>&1 &
