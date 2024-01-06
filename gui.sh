#!/bin/bash

# Update the package list and upgrade existing packages
sudo apt update && sudo apt upgrade -y

# Install the XFCE4 desktop environment and its goodies
apt install xfce-desktop xorg -y
apt install novnc x11vnc tigervnc-standalone-server dbus-x11 python-py python3-pip -y
pip install numpy
pip3 install numpy
dbus-launch

# Set up the VNC server to start at boot and use XFCE4 as the default desktop environment
sudo bash -c 'cat << EOF > /etc/systemd/system/vncserver@.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=root
Group=root
WorkingDirectory=/root
PIDFile=/root/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 -localhost :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF'

# Enable and start the VNC server
sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1.service

# Set a VNC password for the root user
echo "Setting VNC password for root user..."
sudo -u root echo -e "726268\n726268" | vncpasswd

# Restart the VNC server to apply the password
sudo systemctl restart vncserver@1.service

# START NOVNC
/usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc localhost:5900

echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts
echo "Setup complete. You can now connect to the XFCE4 desktop environment via VNC on port 5901."


