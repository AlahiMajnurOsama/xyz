#!/bin/bash



# Update the package index
sudo apt update

# Install Nginx and OpenSSH server
sudo apt install -y nginx openssh-server

# Start Nginx and OpenSSH server
sudo systemctl start nginx
sudo systemctl start ssh

# Enable Nginx and OpenSSH server to start automatically on boot
sudo systemctl enable nginx
sudo systemctl enable ssh


# Install additional packages
sudo apt install curl wget python git unzip tar -y

# Other essential packages can be added here as needed
