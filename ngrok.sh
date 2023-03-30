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
sudo ngrok authtoken 2Ne1wOGAXg3RTt5Cu0EpmU1EZfx_3bM44DaPgHRJACLN7hbwf
ngrok_cmd="sudo ngrok tcp 22 --log \".ngrok.log\" &> /dev/null &"

# Start a new screen session and execute the Ngrok command in it
screen -S ngrok -d -m bash -c "${ngrok_cmd}"

# Print confirmation message
echo "Ngrok tunnel started in a new screen session."
