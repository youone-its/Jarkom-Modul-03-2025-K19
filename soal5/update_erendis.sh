#!/bin/bash

REVERSE_ZONE="3.73.10.in-addr.arpa"
SERIAL=$(date +%Y%m%d%H)

cat > /etc/bind/db.k19.com <<EOF
\$TTL 86400
@   IN  SOA ns1.k19.com. admin.k19.com. (
        $SERIAL  ; Serial
        3600     ; Refresh
        1800     ; Retry
        604800   ; Expire
        86400 )  ; Minimum

@   IN  NS  ns1.k19.com.
@   IN  NS  ns2.k19.com.

ns1 IN  A   10.73.3.3
ns2 IN  A   10.73.3.4

; Alias utama
www IN  CNAME   k19.com.

; Lokasi penting
palantir    IN  A   10.73.4.3
elros       IN  A   10.73.1.6
pharazon    IN  A   10.73.2.3
elendil     IN  A   10.73.1.2
isildur     IN  A   10.73.1.3
anarion     IN  A   10.73.1.4
galadriel   IN  A   10.73.2.4
celeborn    IN  A   10.73.2.5
oropher     IN  A   10.73.2.6

; Pesan rahasia
elros.k19.com.      IN  TXT "Cincin Sauron"
pharazon.k19.com.   IN  TXT "Aliansi Terakhir"
EOF

chown root:bind /etc/bind/db.k19.com
chmod 644 /etc/bind/db.k19.com

cat > /etc/bind/named.conf.local <<EOF
zone "k19.com" {
    type master;
    file "/etc/bind/db.k19.com";
    allow-transfer { 10.73.3.4; };
};

zone "3.73.10.in-addr.arpa" {
    type master;
    file "/etc/bind/db.10.73.3";
    allow-transfer { 10.73.3.4; };
};
EOF

cat > /etc/bind/db.10.73.3 <<EOF
\$TTL 86400
@   IN  SOA ns1.k19.com. admin.k19.com. (
        $SERIAL  ; Serial
        3600     ; Refresh
        1800     ; Retry
        604800   ; Expire
        86400 )  ; Minimum

@   IN  NS  ns1.k19.com.
@   IN  NS  ns2.k19.com.

3   IN  PTR erendis.k19.com.
4   IN  PTR amdir.k19.com.
EOF

chown root:bind /etc/bind/db.10.73.3
chmod 644 /etc/bind/db.10.73.3

service bind9 restart
service bind9 enable
service bind9 status

echo "Erendis Update selesai. Serial: $SERIAL"
echo "  - WWW alias: www.k19.com → k19.com"
echo "  - PTR: 10.73.3.3 → erendis.k19.com, 10.73.3.4 → amdir.k19.com"
echo "  - TXT: 'Cincin Sauron' & 'Aliansi Terakhir' ditambahkan"