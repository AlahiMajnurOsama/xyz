#!/bin/bash

# Install OpenSSH server and set it up to listen on port 22
sudo apt update
sudo apt install openssh-server
sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install additional packages
sudo apt install curl wget python git build-essential

# Other essential packages can be added here as needed
