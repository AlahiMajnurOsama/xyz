#!/bin/bash

# Set environment variable to avoid interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Set the geographic area and time zone selections
echo "tzdata tzdata/Areas select Etc" | sudo debconf-set-selections
echo "tzdata tzdata/Zones/Europe select Moscow" | sudo debconf-set-selections


# Set timezone
echo "Europe/London" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Install nginx with default options
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

# Install Nginx and OpenSSH server
sudo apt install -y openssh-server

# Start Nginx and OpenSSH server
sudo systemctl start nginx

sudo systemctl enable ssh --now

sudo systemctl start ssh

# Enable Nginx and OpenSSH server to start automatically on boot
sudo systemctl enable nginx
sudo systemctl enable ssh


# Install additional packages
sudo apt install curl wget python git unzip tar -y

# Other essential packages can be added here as needed
