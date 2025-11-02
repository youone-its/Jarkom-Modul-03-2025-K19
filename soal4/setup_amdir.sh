#!/bin/bash

apt update && apt install -y bind9

cat > /etc/bind/named.conf.local <<EOF
zone "k19.com" {
    type slave;
    file "/var/cache/bind/db.k19.com";
    masters { 10.73.3.3; };  // Ambil dari Erendis
};
EOF

chown -R root:bind /var/cache/bind/
chmod -R 775 /var/cache/bind/

service bind9 restart
service bind9 enable
service bind9 status

sleep 3

echo "Amdir DNS Slave ready. Checking zone transfer..."
if [ -f /var/cache/bind/db.k19.com ]; then
    echo "Amdir Zone transfer successful!"
else
    echo "Amdir Zone transfer failed. Check master config."
fi