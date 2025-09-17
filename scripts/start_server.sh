#!/bin/bash
cd /home/ec2-user/flask-todo-app || exit 1

echo ">>> Stopping old Flask app if running..."
pkill -f "python3 app.py" || true

echo ">>> Starting Flask app..."
nohup python3 app.py > /home/ec2-user/flask-todo-app/app.log 2>&1 &

echo ">>> Flask started with PID $!" >> /home/ec2-user/flask-todo-app/deploy.log
