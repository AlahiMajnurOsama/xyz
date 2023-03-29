#!/bin/bash

# Download and install Ngrok
cd /tmp
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin/ngrok

# Set up Ngrok to forward port 22
sudo ngrok authtoken <YOUR_AUTH_TOKEN>
sudo ngrok tcp 22
