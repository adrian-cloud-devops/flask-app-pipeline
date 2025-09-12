#!/bin/bash
echo "Stopping Flask app if running..."
pkill -f "python3 app.py" || true
