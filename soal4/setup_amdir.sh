#!/bin/bash

apt update && apt install -y bind9
ln -s /etc/init.d/named /etc/init.d/bind9

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

dig @10.73.3.3 k19.com AXFR
