
#!/bin/bash# TakeOnLan.sh
# Project homepage: https://github.com/ebbeli
# Version 0.01

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
printf "TakeOnLan, tool for wake-on-lan configuration & usage.

This tool is for taking control over your lan or something like that.

Use it to manage Wake-on-lan on your LAN.

Install ethtool and wakeonlan with your package manager to get all features working.

Launch using 'sudo bash TakeOnLan.sh' to use all features.

Add PC:         You can save addresses to .txt file for later

Delete PC:      Delete them from said list.

Route PC:       Add saved address as static into ARP-routing table.(Helpful with RPi in my case)

Wake PC:        Send magic packet to saved address.

PC's config:      PC's configurations. Show ARP-table, check wake-on support and enable wake-on for net interface.
"

else
        echo "TAKE-ON-LAN:"
        exit_msg="TAKE-ON-LAN:\n1) Add PC\n2) Delete PC \n3) Route PC\n4) Wake PC\n5) PC's config\n6) Exit"
        MYDIR="$(dirname "$(readlink -f "$0")")"
        PS3='Choose option: '
        options=("Add PC" "Delete PC" "Route PC" "Wake PC" "PC's config" "Exit")
        select opt in "${options[@]}"
        do
                case $opt in
                "Add PC")
                        bash $MYDIR/Tools/AddPC.sh "$exit_msg"
                        ;;
                "Delete PC")
                        bash $MYDIR/Tools/DeletePC.sh "$exit_msg"
                        ;;
                "Route PC")
                        bash $MYDIR/Tools/RoutePC.sh "$exit_msg"
                        ;;
                "Wake PC")
                        bash $MYDIR/Tools/WakePC.sh  "$exit_msg"
                        ;;
                "PC's config")
                        bash $MYDIR/Tools/ConfigPC.sh "$exit_msg"
                        ;; 
                "Exit")
                echo "Quitting..."
                        break
                        ;;
                *) echo "invalid option $REPLY";;
                esac
        done
fi
