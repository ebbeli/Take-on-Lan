
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

if [[ $1 = "-h" ]] || [[ $1 == "-help" ]]; then
printf "TakeOnLan, tool for wake-on-lan configuration & usage.

This tool is for taking control over your lan or something like that.
Use it to manage Wake-on-lan on your LAN.
Launch using 'sudo bash TakeOnLan.sh' to use all features.

Add PC:         You can save addresses to .txt file for later

Delete PC:      Delete them from said list.

Route PC:       Coming! Add saved address as static into ARP-routing table.(Helpful with RPi in my case)

Enable WoL:     Coming! Enable Wake-On-Lan on current computer.

Wake PC:        Send magic packet to saved address.
"

else
        MYDIR="$(dirname "$(readlink -f "$0")")"

        PS3='Choose option: '
        options=("Add PC" "Delete PC" "Route PC" "Enable WoL" "Wake PC" "Exit")
        select opt in "${options[@]}"
        do
                case $opt in
                "Add PC")
                bash $MYDIR/AddPC.sh "1"
                        ;;
                "Delete PC")
                bash $MYDIR/DeletePC.sh "1"
                        ;;
                "Route PC")
                        echo "Under construction."
                        ;;
                "Enable WoL")
                        echo "Under construction."
                        ;; 
                "Wake PC")
                        bash $MYDIR/WakePC.sh "1"
                        ;;
                "Exit")
                echo "Quitting..."
                        break
                        ;;
                *) echo "invalid option $REPLY";;
                esac
        done
fi
