#!/bin/bash

# Check if addressess.txt exist
if [ ! -f addresses.txt ]; then
    echo "File: addresses.txt was not found. Use menu option Add PC to make new one."
    exit 1
fi

echo -e $1

#Choose exit message based on script passing a variable
if [ -z "$1" ]
then
        exit_msg="\nQuitting script"
else
        exit_msg=$1
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
	echo "$exit_opt) Main Menu "
# Prompt for the selected address
read -p "Which PC to ping: " selected_index



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


# Send pings x p_times
read -p "How many packets: " p_time
echo "Sending ping to $name.."
ping -c ${p_time} ${ip_address}

echo -e "${exit_msg}"
exit 0
