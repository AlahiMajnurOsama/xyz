#!/bin/bash

echo "Changing root password and all user passwords..."
echo "New password: 726268"

# Use sudo to change the root password
echo "root:726268" | sudo chpasswd

# Get a list of all non-system users on the system
users=$(getent passwd | awk -F: '$3 >= 1000 && $1 != "nobody" { print $1 }')

# Loop through each user and change their password using sudo
for user in $users
do
  echo "$user:726268" | sudo chpasswd
done

echo "Passwords changed successfully!"
