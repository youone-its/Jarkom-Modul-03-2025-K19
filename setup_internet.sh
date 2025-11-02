#!/bin/bash
ip addr add 192.168.122.2/24 dev eth0
ip link set eth0 up
ip route add default via 192.168.122.1 dev eth0
ip link set eth1 up
ip addr add 10.73.1.1/24 dev eth1
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.73.0.0/16
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt update
apt install iptables -y
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.73.0.0/16