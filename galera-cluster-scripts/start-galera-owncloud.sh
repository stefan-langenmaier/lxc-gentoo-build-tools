IP=192.168.122.59
# galera traffic
PORT=4567
iptables -I FORWARD -d $IP/32 -p udp -m state --state NEW -m udp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p udp --dport $PORT -j DNAT --to $IP:$PORT
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT
# IST traffic
PORT=4568
iptables -I FORWARD -d $IP/32 -p udp -m state --state NEW -m udp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p udp --dport $PORT -j DNAT --to $IP:$PORT
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT
# SST traffic
PORT=4444
iptables -I FORWARD -d $IP/32 -p udp -m state --state NEW -m udp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p udp --dport $PORT -j DNAT --to $IP:$PORT
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT

mount -o subvol=vols/galera-owncloud /dev/mmcblk0p3  /vols/galera-owncloud/
mount -o subvol=galera-data-owncloud /dev/mapper/data-01  /data/galera-data-owncloud/
lxc-start -n galera-cluster -P /vols/galera-owncloud/
