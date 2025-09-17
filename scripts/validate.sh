#!/bin/bash
set -e

LOG_FILE="/home/ec2-user/flask-todo-app/deploy.log"

echo ">>> Validating Flask app..." >> $LOG_FILE

# Check if process is running
if pgrep -f "python3 app.py" > /dev/null; then
    echo "Process is running" >> $LOG_FILE
else
    echo "Process is NOT running!" >> $LOG_FILE
    exit 1
fi

# Wait a bit for app + nginx to fully start
sleep 10

echo ">>> Curling localhost on port 80" >> $LOG_FILE
curl -f http://localhost/ >> $LOG_FILE 2>&1 || exit 1
