IP=192.168.122.79
# https
PORT=443
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT
## http
PORT=80
iptables -I FORWARD -d $IP/32 -p tcp -m state --state NEW -m tcp --dport $PORT -j ACCEPT
iptables -t nat -I PREROUTING -i eth0 -p tcp --dport $PORT -j DNAT --to $IP:$PORT

mount /var/lib/lxc/nextcloud-emilie/
mount /data/nextcloud/
lxc-start -n nextcloud-emilie
