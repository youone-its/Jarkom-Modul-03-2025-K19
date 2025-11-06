#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update
apt install -y lynx apache2-utils htop

echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

unset http_proxy https_proxy

echo "[Client] Ready! Test with:"
echo "  lynx http://laravel.k19.com"
echo "  curl http://elendil.k19.com:8001/api/airing"
echo "  ab -n 100 -c 10 http://laravel.k19.com/"