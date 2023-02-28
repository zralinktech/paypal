#!/bin/bash

# Prompt for the username and password for each of the three users
read -p "Enter the username for user1: " user1
sudo useradd -m $user1
sudo passwd $user1

read -p "Enter the username for user2: " user2
sudo useradd -m $user2
sudo passwd $user2

read -p "Enter the username for user3: " user3
sudo useradd -m $user3
sudo passwd $user3

# Create a new group and add the users to the group
echo "Enter the name of the new usergroup for sudoers"
read -p "Enter new group name here: " newgroup
sudo groupadd $newgroup
sudo usermod -aG $newgroup $user1
sudo usermod -aG $newgroup $user2
sudo usermod -aG $newgroup $user3

# Grant sudo privileges to the new group
echo "%$newgroup ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$newgroup

# Display the created users and their passwords
echo "The following users were created and added to $newgroup:"
echo "User: $user1"
echo "User: $user2"
echo "User: $user3"
echo "========================================================================="
echo "Please remember to change your password during your first login"
sudo getent passwd | awk -F: '$3 >= 1000 {print $1,$6}' #sudo tail /etc/passwd | awk -F: '$3 >= 1000 {print $1,$6}

