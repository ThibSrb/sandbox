#!/bin/bash

# Generate SSH host keys if they don't exist
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Check if SSH_PASSWORD environment variable is set and update the password for 'sandbox' user
if [ ! -z "$SSH_PASSWORD" ]; then
    echo "sandbox:$SSH_PASSWORD" | chpasswd
fi


# Fix permissions for the home directory
chown -R sandbox:sandbox /home/sandbox

# Start the SSH daemon
exec "$@"
