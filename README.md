# Take-on-Lan (ToL)

ToL is command line tool with simple menu for Linux/GNU to take control over your wake-on-lan or something like that. 
Made for configuring device's for 'wake on lan'. Then controlling whole network from single access point's command line. Like raspberry pi with remote connection. 
Main idea was that i don't have to keep my personal server's running up all the time and i can save electricity with only one low-power device running on the network.
I tried to use purely shell and avoid package requirements for easy installations and wider compatibility.

### Depencies
`sudo apt isntall ethtool`
- Install ethtool to check and configure 'wake on lan'-features for your network interface.
- Everything else should work without installations.

###  Compatibility 
`sudo bash ToL.sh`
- Use with root rights so all features work properly.
- Enable settings for Wake on Lan on your bios.  Google for more info.
- Tested OS: Raspbian Lite (Buster), Fedora 38, Ubuntu 22.04.
- Tested H/W: Raspberry Pi 1B, Thinkpad T480, Optiplex 5050 Micro

## Features

Manage and use wake-on on your LAN.

` bash ToL.sh -h ` / ` bash ToL.sh -help`

### Add PC
You can save PC with nickname* and its MAC*, IP-address and port to use with 'wake on lan'. to txt file for later usage.One or multiple at time (*Required)

### Delete PC
Delete PCs from said list.

### Route PC
Add saved PC's IP and MAC as static into ARP* table so you can send magic packet even when device isn't responding. Helful after long time, in new lan, after reinstall, memory loss etc.

*ARP = Advanced Resolution Protocol. Contains known devices' MACs and IPs so your computer can send and route packets to right anddress and connect to them.

### Wake PC
Choose saved PC and send magic packet to saved address using script. (Wol.sh: https://github.com/leestevetk/WoL.sh)
#### PC's config
PC's configurations. Contains next menu options.
##### Show ARP
Show ARP-table. See known addresses and used network interface. 
##### Set iface
Set network interface for configuration.
##### Get iface
Get network interface automatically for configuration.
##### WoL-config
Check wake-on support and status for said interface.
##### Enable WoL
Enable wake-on-lan for said interface.
##### Help / Guide
Self explanatory.
