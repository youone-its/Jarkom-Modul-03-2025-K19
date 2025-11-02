#!/bin/bash

NODE_NAME=${1:-"client"}

echo "[$NODE_NAME] Installing CA certificates (for HTTPS)..."
apt update && apt install -y ca-certificates

cat > /etc/profile.d/proxy.sh <<EOF
export http_proxy="http://10.73.5.2:3128"
export https_proxy="http://10.73.5.2:3128"
EOF

source /etc/profile.d/proxy.sh

echo "[$NODE_NAME] Proxy configured:"
echo "http_proxy=$http_proxy"
echo "https_proxy=$https_proxy"

echo "[$NODE_NAME] Testing HTTP via proxy..."
curl -sI http://google.com | head -n 1

echo "[$NODE_NAME] Testing HTTPS via proxy..."
curl -sI https://google.com | head -n 1

echo "[$NODE_NAME] Done."