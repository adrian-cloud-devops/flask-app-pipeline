#!/bin/bash
echo "Waiting for Flask to start..."
sleep 10
curl -f http://localhost:5000/ || exit 1
