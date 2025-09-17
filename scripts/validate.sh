#!/bin/bash
echo ">>> Validating Flask app..." >> /home/ec2-user/flask-todo-app/deploy.log

if pgrep -f "python3 app.py" > /dev/null
then
  echo "Process is running" >> /home/ec2-user/flask-todo-app/deploy.log
else
  echo "Process is not running!" >> /home/ec2-user/flask-todo-app/deploy.log
  exit 1
fi

# we are waiting a little bit to start app
sleep 5

echo ">>> Curling localhost:5000 ..." >> /home/ec2-user/flask-todo-app/deploy.log
curl -s http://localhost:5000/ >> /home/ec2-user/flask-todo-app/deploy.log 2>&1 || exit 1
