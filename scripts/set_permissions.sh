#!/bin/bash
echo ">>> Fixing permissions..."
sudo chown -R ec2-user:ec2-user /home/ec2-user/flask-todo-app
chmod +x /home/ec2-user/flask-todo-app/scripts/*.sh
