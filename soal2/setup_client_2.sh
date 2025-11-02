#!/bin/bash

ip addr add 10.73.2.100/24 dev eth0
ip route add default via 10.73.2.1 dev eth0

apt update && apt install -y isc-dhcp-client iproute2 iputils-ping ca-certificates
ip addr flush dev eth0

cat > /etc/network/interfaces <<EOF
auto eth0
iface eth0 inet dhcp
EOF

dhclient -v eth0

sleep 2

ip -br a show eth0
ip route

cat /etc/resolv.conf