#!/bin/bash

# Check if addressess.txt exist
if [ ! -f addresses.txt ]; then
    echo "File: addresses.txt was not found. Use menu option Add PC to make new one."
    exit 1
fi

#Choose exit message based on script passing a variable
if [ -z "$1" ]
then
        exit_msg="\nQuitting script"
else
        exit_msg="$1"
fi

# Read addresses into an array
addresses=()
while IFS= read -r line; do
    addresses+=("$line")
done < addresses.txt

exit_opt=$((${#addresses[@]}+1));

# Display addresses
echo "Saved addresses:"
for index in "${!addresses[@]}"; do
	i=$((${index}+1));
	IFS=',' read -ra address <<< ${addresses[$index]};
	echo "$i) ${address[0]}: ${address[1]}"
done
	echo "$exit_opt) Exit "
# Prompt for the selected address
read -p "Which address to add: " selected_index



# Check exit and invalid input
if [ $selected_index -eq $exit_opt ]
then
	echo -e "${exit_msg}"
	exit 0
fi

if [[ ! "$selected_index"=~^[0-9]+$ ]] || ((selected_index < 0 || selected_index >= ${exit_opt}));
then
	echo "Invalid input, exiting.."
	exit 1
fi

#Change menu index back to real index
real_index=$((${selected_index}-1))

# Extract addresss info from selected index
selected_address=(${addresses[$real_index]})
name=$(echo "$selected_address" | awk -F, '{print $1}')
ip_address=$(echo "$selected_address" | awk -F, '{print $2}')
mac_address=$(echo "$selected_address" | awk -F, '{print $3}')
port=$(echo "$selected_address" | awk -F, '{print $4}')

if [[ $ip_address = "255.255.255.255" ]]; then
	read -p "$name's IP is 255.255.255.255. It's broadcast address, are you sure (Y/N): " confirm
fi
if [[ $confirm = "n" ]] || [[ $confirm = "N" ]]; then
	echo "PC not added."
	read
else
	# Send packet using wakeonland and address info
	echo "Trying to add $name to routing table: "
	sudo arp -s ${ip_address} ${mac_address}
fi
echo -e "${exit_msg}"
exit 0