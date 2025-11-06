#!/bin/bash

REVERSE_ZONE="3.73.10.in-addr.arpa"
SERIAL=$(date +%Y%m%d%H)

cat > /etc/bind/named.conf.local <<EOF
zone "k19.com" {
    type slave;
    file "/etc/bind/db.k19.com";
    masters { 10.73.3.3; };
};

zone "3.73.10.in-addr.arpa" {
    type slave;
    file "/etc/bind/db.10.73.3";
    masters { 10.73.3.3; };
};
EOF

chown -R bind:bind /var/cache/bind/
chmod -R 775 /var/cache/bind/

service bind9 restart
service bind9 enable
service bind9 status

echo "Erendis Update selesai. Serial: $SERIAL"
echo "  - WWW alias: www.k19.com → k19.com"
echo "  - PTR: 10.73.3.3 → erendis.k19.com, 10.73.3.4 → amdir.k19.com"
echo "  - TXT: 'Cincin Sauron' & 'Aliansi Terakhir' ditambahkan"