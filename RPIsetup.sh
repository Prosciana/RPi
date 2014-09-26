# Rasp Pi Setup
# in host
# format
df -h
# unmount
sudo dd bs=1m if=[DISK IMAGE NAME] of=[FILESYSTEM] #/dev/rdiskn
# Power on, disconnected WIFI
sudo nano /etc/network/interfaces
# Paste
# auto lo

# iface lo inet loopback
# iface eth0 inet dhcp

# allow-hotplug wlan0
# auto wlan0


# iface wlan0 inet dhcp
#         wpa-ssid "INFINITUMCE8BEB"
#         wpa-psk "37DB81D554"
sudo halt
# Connect WIFI 
# Power on
# DevApps Setup

# Arduino & INO interface
sudo apt-get update
sudo apt-get install arduino -y
sudo apt-get install python-dev python-setuptools -y
git clone git://github.com/amperka/ino.git
cd ino
sudo python setup.py install
sudo apt-get install picocom -y
cd


