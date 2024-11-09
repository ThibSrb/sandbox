#!/bin/bash

# Check if a password argument is provided
if [ -z "$1" ]; then
  echo "Usage: ./launch.sh <ssh_password>"
  exit 1
fi

# Assign the first argument to PASSWORD
PASSWORD=$1

# Run the podman container with the provided password
podman run --name sandbox \
-v ./data:/home/sandbox:Z \
-d -p 4000:22 \
-e SSH_PASSWORD=$PASSWORD \
sandbox
