#!/bin/bash

apt update && apt install -y isc-dhcp-server
cat > /etc/default/isc-dhcp-server <<EOF
INTERFACESv4="eth0"
EOF

KHAMUL_MAC=${KHAMUL_MAC:-"02:42:85:57:34:00"}

cat > /etc/dhcp/dhcpd.conf <<EOF
authoritative;
option domain-name "k19.com";
option domain-name-servers 192.168.122.1;

subnet 10.73.4.0 netmask 255.255.255.0 {
    option routers 10.73.4.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    pool { range 10.73.4.10 10.73.4.50; }
}

subnet 10.73.1.0 netmask 255.255.255.0 {
    option routers 10.73.1.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    pool { range 10.73.1.7 10.73.1.34; }
    pool { range 10.73.1.68 10.73.1.94; }
}

subnet 10.73.2.0 netmask 255.255.255.0 {
    option routers 10.73.2.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    pool { range 10.73.2.35 10.73.2.67; }
    pool { range 10.73.2.96 10.73.2.121; }
}

subnet 10.73.3.0 netmask 255.255.255.0 {
    option routers 10.73.3.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
}

host Khamul {
    hardware ethernet $KHAMUL_MAC;
    fixed-address 10.73.3.95;
}
EOF

echo "[Aldarion] Starting DHCP server..."

service isc-dhcp-server restart
service isc-dhcp-server enable
service isc-dhcp-server status