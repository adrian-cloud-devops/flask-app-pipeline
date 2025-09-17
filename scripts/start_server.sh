#!/bin/bash
echo "Starting Flask app..." >> /home/ec2-user/flask-todo-app/deploy.log 2>&1
cd /home/ec2-user/flask-todo-app || exit 1
echo "Current dir: $(pwd)" >> deploy.log 2>&1
nohup python3 app.py >> deploy.log 2>&1 &
echo "Flask started with PID $!" >> deploy.log 2>&1
