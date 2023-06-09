#!/bin/bash

# Create file if not found
if [ ! -f addresses.txt ]; then
    > addresses.txt
    exit 1
fi

#Choose exit message based on script passing a variable
if [ -z "$1" ]
then
        exit_msg="\nQuitting script"
else
        exit_msg=$1
fi

# Ask number of PC:s
read -p "How many PCs you want to add?: " pc_count
# Quit if 0
if [[ $pc_count -eq 0 ]]; then
	echo "No PCs added."
	echo -e ${exit_msg}
	exit 0
fi

# Check if the number of inputs is valid
reg='^[0-9]+$'
if ! [[ $pc_count =~ $reg ]]; then
	echo "Invalid input. Please enter a positive integer."
	exit 1
fi

# Regex for mac
mac_reg="^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$"

# Read input in loop and check if n
for ((i=1; i<=$pc_count; i++)); do
	# Format variables for while loops in multiple entries
	has_name=false
	valid_mac=false
	while ! $has_name; do
		read -p "Enter name for $i.PC: " name
		if [[ -z "$name" ]]; then
		 	echo "Name is required. Try again."
			read
		else
			has_name=true
		fi
	done
	while ! $valid_mac; do
	read -p "$name's MAC: " mac_add
		if [[ ! $mac_add =~ $mac_reg ]]; then
		 	echo "Mac was invalid. Try again."
		else
			valid_mac=true
		fi
	done
    read -p "$name's IP (Empty = 255.255.255.255): " ip_add
	read -p "$name's Port (Empty = 9) $i:" port_add
	# Set default values if empty
	[ -z "$ip_add" ] && ip_add=255.255.255.255
	[ -z "$port_add" ] && port_add=9
	# Append to fle
	echo "$name,$ip_add,$mac_add,$port_add" >> addresses.txt
	echo "$name was saved"
	read
done
echo -e "$exit_msg"
exit 0