#!/bin/bash

apt update && apt install -y lynx

cat > /etc/resolv.conf <<EOF
nameserver 10.73.3.3
nameserver 10.73.3.4
EOF

unset http_proxy https_proxy

echo "[Client] Ready to test!"
echo "Usage: lynx http://<worker>.k19.com"
echo "Example: lynx http://elendil.k19.com"