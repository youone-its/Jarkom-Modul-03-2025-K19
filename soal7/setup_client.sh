#!/bin/bash
sed -i '1i nameserver 192.168.122.1' /etc/resolv.conf

apt update && apt install -y lynx

cat > /etc/resolv.conf <<EOF
nameserver 10.73.3.3
nameserver 10.73.3.4
EOF

unset http_proxy https_proxy

echo "[Client] Ready to test!"
echo "Usage: lynx http://<worker>.k19.com"
echo "Example: lynx http://elendil.k19.com"
echo "Example: lynx http://isildur.k19.com"
echo "Example: lynx http://anarion.k19.com"