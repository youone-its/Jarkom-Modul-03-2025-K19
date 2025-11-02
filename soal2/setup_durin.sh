#!/bin/bash

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

apt update && apt install -y isc-dhcp-relay

cat > /root/start-dhcp-relay.sh <<'EOF'
#!/bin/bash
dhcrelay -4 10.73.4.2 eth1 eth2 eth3 > /var/log/dhcrelay.log 2>&1 &
echo "DHCP relay started (PID: $!)"
EOF

chmod +x /root/start-dhcp-relay.sh

/root/start-dhcp-relay.sh