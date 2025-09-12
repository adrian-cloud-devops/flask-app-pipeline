#!/bin/bash
echo "Stopping Flask app..."
pkill -f "python3 app.py" || echo "No process found to stop"
