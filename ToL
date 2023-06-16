
#!/bin/bash# TakeOnLan.sh
# Project homepage: https://github.com/ebbeli
# Version 0.21

# MIT License

# Copyright (c) 2023 ebbeli

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

if [[ $1 = "-h" ]] || [[ $1 = "-help" ]]; then
printf "
TakeOnLan, tool for wake-on-lan configuration & usage.

This tool is for taking control over your lan or something like that.

Use it to manage Wake-on-lan on your LAN.

Install ethtool and wakeonlan with your package manager to get all features working.

Launch using 'sudo bash TakeOnLan.sh' to use all features.

1. SAVED PCs: Select saved PC from list to use the actions:
   1.1 WAKE UP: Send magic packet using saved info to wake PC.
   1.2 PING: Send ping to saved IP to test if PC is up and running.
   1.3 ADD ARP: Add saved IP & MAC as static into 'Address Resolution Protocol'-table.
   1.4 DELETE: Delete PC from said list and addresses.txt.
   1.5 CHANGE PC: Choose another PC from list.
   
2. ADD PC: Use nickname* to save IP, MAC* and port to addresses.txt.\*=Required Info.

3. PC's config: PC's configurations. Network interface configuration and ARP-table.
   3,1 INTERFACES: Show PC's network interfaces and their IP, MAC & other info.
   3.2 SET IFACE: Enter interface name or get automatically currently used one.
   3.4 WOL-CONFIG: Show selected interface's wake-on support and current configuration.
   3.5 ENABLE WOL: Enable wake-on for currently sected interface.
   3.6 ARP-TABLE: Show ARP-table to see known IP- & MAC-address combinations.

4. QUIT: Exit application.

"

else
        echo "TAKE-ON-LAN:"
        exit_msg="TAKE-ON-LAN:\n1) Saved PCs\n2) Add PC\n3) This PC\n4} Quit"
        MYDIR="$(dirname "$(readlink -f "$0")")"
        PS3='Choose option: '
        options=("Saved PCs" "Add PC" "This PC" "Quit")
        select opt in "${options[@]}"
        do
                case $opt in
                "Saved PCs")
                        bash $MYDIR/Tools/Actions.sh "$exit_msg"
                        ;;
                "Add PC")
                        bash $MYDIR/Tools/AddPC.sh "$exit_msg"
                        ;;

                "This PC")
                        bash $MYDIR/Tools/ThisPC.sh "$exit_msg"
                        ;; 
                "Quit")
                echo "Quitting..."
                        break
                        ;;
                *) echo "invalid option $REPLY";;
                esac
        done
fi
