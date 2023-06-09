#!/bin/bash
set_iface=""

PS3='Choose option: '
options=("Show ARP" "Give iface" "Get iface" "Iface conf" "Enable WoL" "Exit")
select opt in "${options[@]}"
do
        case $opt in
        "Show ARP")
                echo "Showing arp-table for ifaces. Usual default is eth0 / wlan0"
                arp -a
                ;;
        "Give iface")
                read -p "Write interface name: " set_iface
                ;;
        "Get iface")
                echo "Make sure you have WAN / LAN -connection and type ip to ping. Defaults to Google: 8.8.8.8 if left empty."
                read -p "IP:" ping_ip
                if [ -z "$ping_ip" ]; then
                    ping_ip=8.8.8.8
                fi
                set_iface=$(ip route get ${ping_ip} | sed -n 's/.*dev \([^\ ]*\).*/\1/p')
                echo "Pinged ${ping_ip}. Interface used: ${set_iface}"
                ;;
        "Iface conf")
                if [ -z "$set_iface" ]; then
                    echo "Give or get interface name with options 2 / 3"
                else
                    sudo ethtool ${set_iface}
                fi
                ;;
        "Enable WoL")
                if [ -z "$set_iface" ]; then
                    echo "Give or get interface name with options 2 / 3"
                else
                    sudo ethtool -s ${set_iface} wol g
                fi
                ;; 
        "Exit")
        echo "Quitting..."
                break
                ;;
        *) echo "invalid option $REPLY";;
        esac
done