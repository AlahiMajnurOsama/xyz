#!/bin/bash

# Install OpenSSH server and set it up to listen on port 22
sudo apt-get update
sudo apt-get install -y openssh-server
sudo apt-get install -y unzip

sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
sudo systemctl restart sshd


# Install additional packages
sudo apt install curl wget python git

# Other essential packages can be added here as needed
