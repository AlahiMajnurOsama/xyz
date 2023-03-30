#!/bin/bash

# Download netcat
sudo apt-get update
sudo apt-get install netcat -y

# Connect to IP address and port
nc 3.111.20.191 7262
