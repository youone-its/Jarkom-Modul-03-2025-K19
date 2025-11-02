#!/bin/bash

apt update && apt install -y squid

cp /etc/squid/squid.conf /etc/squid/squid.conf.bak

cat > /etc/squid/squid.conf <<EOF
acl localnet src 10.73.0.0/16
http_access allow localnet
http_access deny all
http_port 3128
visible_hostname Minastir
EOF

service squid restart
service squid enable
service squid status

echo "Minastir Done. Forward proxy running on http://10.73.5.2:3128"