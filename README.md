# Take-on-Lan (ToL)

ToL is command line tool with simple menu for Linux/GNU to take control over your wake-on-lan or something like that.
Made for configuring device's for 'wake on lan'. Then controlling whole network from single access point's command line. Like raspberry pi with remote connection.
Main idea was that i don't have to keep my personal server's running up all the time and i can save electricity with only one low-power device running on the network.
I tried to use purely shell and avoid package requirements for easy installations and wider compatibility.


### DEPENCIES

`sudo apt isntall ethtool`

- Install ethtool to check and configure 'wake on lan'-features for your network interface.
- Everything else should work without installations.

### COMPATIBILITY

- Enable settings for Wake on Lan on your bios. Google for more info about your MB/PC.
- Use with root rights so all features work properly.
  - `sudo bash ToL`
- Some configurations may need to make files executable again if there given permission isn't valid. Use next command for ToL and files in Tools folder:
  - `chmod +x filename`
- Tested OS: Raspbian Lite (Buster), Fedora 38, Ubuntu 22.04.
- Tested H/W: Raspberry Pi 1B, Thinkpad T480, Optiplex 5050 Micro

### HELP
  - `bash ToL -h / bash ToL -help`

## FEATURES

Take-on-Lan is tool for wake-on-lan configuration & usage with simple TUI(Text-based user interface) . With simple menu, it can make tasks with tedious repetation easier and faster.

### MENU ITEMS:

#### SAVED PCs

Select saved PC from list to use the actions

- WAKE UP : Send magic packet using saved info to wake PC.
- PING : Send ping to saved IP to test if PC is up and running.
- ADD ARP : Add saved IP & MAC as static into 'Address Resolution Protocol'-table.
- DELETE : Delete PC from said list and addresses.txt
- CHANGE PC : Choose another PC from list.
- MAIN MENU

#### ADD PC

Use nickname* to save IP, MAC* and port to addresses.txt.

- \*Required Info.

#### THIS PC

PC's configurations. Network interface configuration and ARP-table.

- INTERFACES : Show PC's network interfaces and their IP, MAC & other info.
- SET IFACE : Enter interface name or get automatically currently used one.
- WOL-CONFIG : Show selected interface's wake-on support and current configuration.
- ENABLE WOL : Enable wake-on for currently sected interface.
- ARP-TABLE : Show ARP-table to see known IP- & MAC-address combinations.
- HELP/GUIDE : Self explanatory
- MAIN MENU

#### QUIT

Exit application.

### EXTRA / USE AS COMMAND

If you want to use this as basic command tool wihout using it from directory.

1. Create directory bin to your home folder (Example: "/home/user")
2. Extract ToL directory to created folder. ( At least ToL-file and Tools folder. )
   - `cd ToL`
   - `mv * /home/bin/`
3. Add this PATG to your .profile or .bash_profile
   - `sudo echo 'export PATH=$PATH":$HOME/bin"' >> /home/user/.profile`
4. Reload .profile
   - `~/.bash_profile`
5. Now you can use it at command line with(Remember case sensitivity):
   - `ToL`

Ps. After doing that you can add your own scripts into folder to use as commands. It's convient so you can easily separate them from installed ones.
