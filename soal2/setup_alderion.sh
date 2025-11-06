#!/bin/bash

apt update && apt install -y isc-dhcp-server

cat > /etc/default/isc-dhcp-server <<EOF
INTERFACESv4="eth0"
EOF

cat > /etc/dhcp/dhcpd.conf <<EOF
authoritative;
option domain-name "k19.com numenor.local";
option domain-name-servers 192.168.122.1;

subnet 10.73.4.0 netmask 255.255.255.0 {
    option routers 10.73.4.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    range 10.73.4.250 10.73.4.250;
}

subnet 10.73.1.0 netmask 255.255.255.0 {
    option routers 10.73.1.1;
    option broadcast-address 10.73.1.255;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    default-lease-time 3600;
    max-lease-time 7200;

    pool { range 10.73.1.7 10.73.1.34; }
    pool { range 10.73.1.68 10.73.1.94; }
}

subnet 10.73.2.0 netmask 255.255.255.0 {
    option routers 10.73.2.1;
    option broadcast-address 10.73.2.255;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
    default-lease-time 3600;
    max-lease-time 7200;

    pool { range 10.73.2.35 10.73.2.67; }
    pool { range 10.73.2.96 10.73.2.121; }
}

subnet 10.73.3.0 netmask 255.255.255.0 {
    option routers 10.73.3.1;
    option domain-name-servers 10.73.3.3, 10.73.3.4;
}

host Khamul {
    hardware ethernet 02:42:85:57:34:00;
    fixed-address 10.73.3.95;
}
EOF

service isc-dhcp-server restart
service isc-dhcp-server enable
service isc-dhcp-server status