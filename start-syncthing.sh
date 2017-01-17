IP=192.168.122.89
# listening port (tcp)
PORT=22000
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT
# discover port (udp)
PORT=21027
iptables -I FORWARD -d $IP/32 -p udp -m state --state NEW -m udp --dport $PORT -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p udp --dport $PORT -j DNAT --to $IP:$PORT
# listening port (tcp)
PORT=8384
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT

mount /var/lib/lxc/syncthing/
mount /data/owncloud/
lxc-start -n syncthing
