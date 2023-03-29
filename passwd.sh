#!/bin/bash

echo "Changing admin password..."
echo "New password: 726268"

# Use sudo to change the password for the root user
echo "root:726268" | sudo chpasswd

echo "Password changed successfully!"
