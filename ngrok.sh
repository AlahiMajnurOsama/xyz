#!/bin/bash
# Install unzip

sudo apt-get install -y unzip
sudo apt-get install -y tar

# Download and install Ngrok
cd /tmp
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin/ngrok

# Set up Ngrok to forward port 22
sudo ngrok authtoken 2Ne1wOGAXg3RTt5Cu0EpmU1EZfx_3bM44DaPgHRJACLN7hbwf
sudo ngrok tcp 22 --log ".ngrok.log" 
