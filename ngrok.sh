#!/bin/bash
# Install unzip

sudo apt-get install -y unzip
sudo apt-get install -y tar
sudo apt-get install -y screen

# Download and install Ngrok
cd /tmp
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin/ngrok

# Set up Ngrok to forward port 22
sudo ngrok authtoken 2O4OxnylX4mv641TEefjiX0d67A_3Ke4mLkXLEFtCoKwLRZCB

