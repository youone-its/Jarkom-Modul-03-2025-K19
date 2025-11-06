#!/bin/bash
echo "nameserver 192.168.122.1" >> /etc/resolv.conf

ip addr add 10.73.1.100/24 dev eth0
ip route add default via 10.73.1.1 dev eth0

apt update && apt install -y isc-dhcp-client
ip addr flush dev eth0

dhclient -v eth0

sleep 2

ip -br a show eth0
ip route

cat /etc/resolv.conf
