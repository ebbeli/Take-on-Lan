#!/bin/bash

#To Do Functiomns
WakePC() {
    # Send packet using wakeonland and address info
    MYDIR="$(dirname "$(readlink -f "$0")")"
    echo "Trying to wake up $name: "
    bash $MYDIR/WoL.sh ${mac_address} ${ip_address} ${port}
    read
    #wakeonlan -i ${ip_address} -p ${port} ${mac_address}
}

PingPC() {
    # Send pings x p_times
    read -p "How many packets: " p_time
    echo "Sending ping to $name.."
    ping -c ${p_time} ${ip_address}
    echo -e "${menu}"
}

RoutePC() {
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
}

DeletePC() {
# Confirm delete
    echo "$name's address: IP: ${ip_address} MAC: ${mac_address} PORT: $port"
    read -p "Confirm deletion of $name (Y/N): " answer

    if [ $answer = "y" ] || [ $answer = "Y" ]; then
        echo "Deleting $name.."
        sed -i "${selected_index}d" addresses.txt
    else
        echo "$name not deleted." 
        read
    fi
}

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
# MAIN LOOP
quit=false
while ! $quit; do
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
    read -p "Choose PC: " selected_index



    # Check exit and invalid input
    if [ $selected_index = $exit_opt ]
    then
        echo -e "${exit_msg}"
        quit=true
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
    #To echo menu after compliting action
    menu="1) Wake $name\n2) Ping $name\n3) Add ARP: $name\n4) Delete $name\n5) Change PC\n6) Main Menu"
    MYDIR="$(dirname "$(readlink -f "$0")")"
    PS3='Choose action: '
    options=("Wake $name" "Ping $name" "Add ARP: $name" "Delete $name" "Change PC" "Main Menu")
    select opt in "${options[@]}"
    do
            case $opt in
            "Wake $name")
                    WakePC
                    ;;
            "Ping $name")
                    PingPC
                    ;;
            "Add ARP: $name")
                    RoutePC
                    ;;
            "Delete $name")
                    DeletePC
                    break
                    ;;
            "Change PC")
                    echo "Quitting..."
                    break
                    ;;
            "Main Menu")
                    quit=true
                    break
                    ;;
            *) echo "invalid option $REPLY";;
            esac
    done
done

echo -e "${exit_msg}"
exit 0