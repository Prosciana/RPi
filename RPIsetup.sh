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


# netatalk & VNC
sudo apt-get update
sudo apt-get install netatalk tightvncserver -y
vncserver :1


# Arduino & INO interface
sudo apt-get update
sudo apt-get install arduino -y
sudo apt-get install python-dev python-setuptools -y
git clone git://github.com/amperka/ino.git
cd ino
sudo python setup.py install
sudo apt-get install picocom -y
cd


# VPN Client
sudo apt-get update
sudo apt-get install -y openswan xl2tpd





# VPN client
sudo apt-get install xl2tpd openswan systemd -y
sudo nano /etc/ipsec.conf 
# Paste and edit
# config setup
# 	virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12
# 	nat_traversal=yes
# 	protostack=netkey
# 	oe=no
# 	  # Replace eth0 with your network interface
#        plutoopts="--interface=eth0"
# conn L2TP-PSK
#        authby=secret
#        pfs=no
#        auto=add
#        keyingtries=3
#        dpddelay=30
#        dpdtimeout=120
#        dpdaction=clear
#        rekey=yes
#        ikelifetime=8h
#        keylife=1h
#        type=transport
#   # Replace IP address with your local IP (private, behind NAT IP is okay as well)
#        left=%any
#        leftnexthop=%defaultroute
#        leftprotoport=17/1701
#   # Replace IP address with your VPN server's IP
#        right=68.68.32.79
#        rightprotoport=17/1701
sudo nano /etc/ipsec.secrets
# Paste
# %any [VPN IP] : PSK "your_pre_shared_key"
sudo ipsec auto --add L2TP-PSK
sudo nano /etc/xl2tpd/xl2tpd.conf
# Paste
  # [lac vpn-connection]
  # lns = 68.68.32.79
  # ppp debug = yes
  # pppoptfile = /etc/ppp/options.l2tpd.client
  # length bit = yes
sudo nano /etc/ppp/options.l2tpd.client
# Paste
 ipcp-accept-local
 ipcp-accept-remote
 refuse-eap
 require-mschap-v2
 noccp
 noauth
 idle 1800
 mtu 1410
 mru 1410
 defaultroute
 usepeerdns
 debug
 lock
 connect-delay 5000
 name your_vpn_username
 password your_password
sudo mkdir -p /var/run/xl2tpd
sudo touch /var/run/xl2tpd/l2tp-control
systemctl start openswan
systemctl start xl2tpd
ipsec auto --up L2TP-PSK
echo "c vpn-connection" > /var/run/xl2tpd/l2tp-control
