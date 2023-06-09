#!/bin/bash
set_iface=""

#Choose exit message based on script passing a variable
if [ -z "$1" ]
then
        exit_msg="\nQuitting script"
else
        exit_msg="$1"
fi

PS3='Choose option: '
options=("Show ARP" "Give iface" "Get iface" "WoL-config" "Enable WoL" "Help/Guide" "Main Menu")
select opt in "${options[@]}"
do
        case $opt in
        "Show ARP")
                echo "Showing 'Address Resolution Protocol'-table for interfaces."
                arp -a
                ;;
        "Give iface")
                read -p "Write interface name: " set_iface
                ;;
        "Get iface")
                echo "Make sure you have WAN/LAN-connection before entering IP. (Empty = 8.8.8.8 / Google's DNS)."
                read -p "IP:" ping_ip
                if [ -z "$ping_ip" ]; then
                    ping_ip=8.8.8.8
                fi
                set_iface=$(ip route get ${ping_ip} | sed -n 's/.*dev \([^\ ]*\).*/\1/p')
                echo "Pinged ${ping_ip}. Interface used: ${set_iface}"
                ;;
        "WoL-config")
                if [ -z "$set_iface" ]; then
                    echo "Give or get interface name with options: 2/3"
                else 
                    ethtool ${set_iface} | grep -i wake
                fi
                ;;
        "Enable WoL")
                if [ -z "$set_iface" ]; then
                    echo "Give or get interface name with options: 2/3"
                else
                    ethtool -s ${set_iface} wol g
                fi
                ;; 
        "Help/Guide")
                echo "1. Make sure ethtool is installed and script is used with root permmission."
                echo "2. You can try to find correct interface with 'Show ARP'. It shows device's ARP-table."
                echo "3. Common interface names are 'eth0' for ethernet and 'wlan0' for wifi"
                echo "4. Set interface with 'Give iface'-option or try get it automatically with 'Get iface'."
                echo "5. Then check support with 'WoL-config'. If wake-on-lan supports 'g'-mode try enabling it with 'Enable WoL'."
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