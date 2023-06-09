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
        exit_msg="\n1) Add PC\n2) Wake PC\n3) Quit"
fi

# Ask number of PC:s
read -p "How many PCs you want to add?: " pc_count

# Check if the number of inputs is valid
re='^[0-9]+$'
if ! [[ $pc_count =~ $re ]]; then
	echo "Invalid input. Please enter a positive integer."
	exit 1
fi


# Read input in loop
for ((i=1; i<=$pc_count; i++)); do
	read -p "Enter name for $i.PC: " name
        read -p "$name's IP: " ip_add
	read -p "$name's MAC: " mac_add
	read -p "$name's Port(Leave empty if not sure, defaults to 9) $i:" port_add

	# Append to fle
      	[ -z "$port_add" ] && port_add=9
	echo "$name,$ip_add,$mac_add,$port_add" >> addresses.txt
done
echo "Addresses have been saved."
echo -e "$exit_msg"
exit 0