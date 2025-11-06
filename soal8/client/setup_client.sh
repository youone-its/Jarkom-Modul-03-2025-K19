#!/bin/bash

echo "Client Installing tools..."
apt update
apt install -y lynx apache2-utils htop

cat > /etc/resolv.conf <<EOF
nameserver 10.73.3.3
nameserver 10.73.3.4
EOF

unset http_proxy https_proxy

echo "  Client Ready! Test with:"
echo "  lynx http://anarion.k19.com:8003"
echo "  lynx http://isildur.k19.com:8002"
echo "  lynx http://elendil.k19.com:8001"
echo "  ab -n 100 -c 10 http://laravel.k19.com/"