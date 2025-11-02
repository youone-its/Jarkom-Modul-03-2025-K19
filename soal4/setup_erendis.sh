#!/bin/bash

apt update && apt install -y bind9 bind9utils

cat > /etc/bind/named.conf.local <<EOF
zone "k19.com" {
    type master;
    file "/etc/bind/db.k19.com";
    allow-transfer { 10.73.3.4; };  // Izinkan Amdir ambil zona
};
EOF

cat > /etc/bind/db.k19.com <<EOF
\$TTL 86400
@   IN  SOA ns1.k19.com. admin.k19.com. (
        2025103003  ; Serial
        3600        ; Refresh
        1800        ; Retry
        604800      ; Expire
        86400 )     ; Minimum

@   IN  NS  ns1.k19.com.
@   IN  NS  ns2.k19.com.

ns1 IN  A   10.73.3.3
ns2 IN  A   10.73.3.4

palantir    IN  A   10.73.4.3
elros       IN  A   10.73.1.6
pharazon    IN  A   10.73.2.3
elendil     IN  A   10.73.1.2
isildur     IN  A   10.73.1.3
anarion     IN  A   10.73.1.4
galadriel   IN  A   10.73.2.4
celeborn    IN  A   10.73.2.5
oropher     IN  A   10.73.2.6
EOF

chown root:bind /etc/bind/db.k19.com
chmod 644 /etc/bind/db.k19.com

service bind9 restart
service bind9 enable
service bind9 status

echo "[Erendis] DNS Master ready. Zone: k19.com"