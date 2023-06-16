#!/bin/bash
set_iface="None"
#Choose exit message based on script passing a variable
if [ -z "$1" ]
then
        exit_msg="\nQuitting script"
else
        exit_msg="$1"
fi


PS3='Choose option: '
options=( "Interfaces" "Set Iface" "WoL-Config" "Enable WoL" "ARP-Table" "Help/Guide" "Main Menu" )
select opt in "${options[@]}"
do
        case $opt in
        "Interfaces")
                echo "Network interfaces."
                ifconfig
                ;;
        "Set Iface")
                echo -e "1) Enter interface's name\n2) Get currently used automatically"
                read -p "Select option: " set_option
                if [[ $set_option = "1" ]]; then
                        read -p "Write interface name: " set_iface
                elif [[ $set_option = "2" ]]; then
                        echo "Make sure you have WAN/LAN-connection before entering IP. (Empty = 8.8.8.8 / Google's DNS)."
                        read -p "IP:" ping_ip
                        if [ -z "$ping_ip" ]; then
                        ping_ip=8.8.8.8
                        fi
                        set_iface=$(ip route get ${ping_ip} | sed -n 's/.*dev \([^\ ]*\).*/\1/p')
                        echo "Pinged ${ping_ip}. Interface used: ${set_iface}"
                else
                        echo "Invalid input"
                fi
                ;;
        "WoL-Config")
                echo "$set_iface: "
                if [[ $set_iface = "None" ]]; then
                    echo "You haven't chosen interface."
                    echo "Give or get interface name with option: 2)"
                else 
                    sudo ethtool ${set_iface} | grep -i wake
                fi
                ;;
        "Enable WoL")
                if [[ $set_iface = "None" ]]; then
                    echo "Give or get interface name with option: 2)"
                else
                    echo "Trying to enable wake-on for: $set_iface"
                    sudo ethtool -s ${set_iface} wol g
                    TEST_VAR="$(sudo ethtool ${set_iface} | grep -i 'Wake-on: g')"
                    if [[ "$TEST_VAR" == *"Wake-on: g"* ]]; then
                        echo "Wake-on enabled succesfully"
                   else
                        echo "Couldn't enable wake-on"
                   fi
                fi
                ;; 

        "ARP-Table")
                echo "Showing 'Address Resolution Protocol'-table."
                arp -a
                ;;
        "Help/Guide")
                echo "1 .WAKE-ON-LAN CONFIGURATION:"
                echo "1.1. Make sure ethtool is installed and script is used with root permmission."
                echo "1.2. You can try to find correct interface with 'Interfaces'. It shows device's all network interfaces."
                echo "1.3. Common interface names are 'eth0' for ethernet and 'wlan0' for wifi"
                echo "1.4. Set interface with 'Set iface'-option. You can give one or try to get one automatically. Make sure network interface is connected."
                echo "1.5. Then check support with 'WoL-config'. If wake-on-lan supports 'g'-mode try enabling it with 'Enable WoL'."
                echo "2. ARP-TABLE:"
                echo "2.1 ARP-table shows known IP & MAC addresses. Add PC to arp table to make sure wake-on-lan functions correctly."
                echo "2.2 Shutdown PC's info may be lost, so go to Main menu and select saved PC and use 'Add ARP'-option for proper functionality"          
                ;;
        "Main Menu")
        echo "Quitting..."
                break
                ;;
        *) echo "invalid option $REPLY";;
        esac
done
echo -e ${exit_msg}
exit 0