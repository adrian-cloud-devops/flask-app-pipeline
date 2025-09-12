#!/bin/bash
echo "Running validate..."
curl -v http://localhost:5000/ || echo "App not responding yet"
