#!/bin/bash
for i in {1..10}
do
  curl -f http://localhost:5000/ && exit 0
  echo "Validation attempt $i failed, retrying..."
  sleep 3
done
echo "App failed to respond on port 5000"
exit 1
