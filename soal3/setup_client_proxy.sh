#!/bin/bash
sed -i '1i nameserver 192.168.122.1' /etc/resolv.conf

apt update && apt install -y ca-certificates

export http_proxy="http://10.73.5.2:3128"
export https_proxy="http://10.73.5.2:3128"
curl -I http://google.com
curl -I https://google.com
