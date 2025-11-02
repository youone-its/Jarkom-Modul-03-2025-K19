#!/bin/bash

DOMAIN="k19.com"
REVERSE_ZONE="3.73.10.in-addr.arpa"
SERIAL=$(date +%Y%m%d%H)

echo "Erendis Memperbarui zona forward: $DOMAIN"

cat > /etc/bind/db.$DOMAIN <<EOF
\$TTL 86400
@   IN  SOA ns1.$DOMAIN. admin.$DOMAIN. (
        $SERIAL  ; Serial
        3600     ; Refresh
        1800     ; Retry
        604800   ; Expire
        86400 )  ; Minimum

@   IN  NS  ns1.$DOMAIN.
@   IN  NS  ns2.$DOMAIN.

ns1 IN  A   10.73.3.3
ns2 IN  A   10.73.3.4

; Alias utama
www IN  CNAME   $DOMAIN.

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
elros.$DOMAIN.      IN  TXT "Cincin Sauron"
pharazon.$DOMAIN.   IN  TXT "Aliansi Terakhir"
EOF

echo "Erendis Memperbarui zona reverse: $REVERSE_ZONE"

cat > /etc/bind/db.10.73.3 <<EOF
\$TTL 86400
@   IN  SOA ns1.$DOMAIN. admin.$DOMAIN. (
        $SERIAL  ; Serial
        3600     ; Refresh
        1800     ; Retry
        604800   ; Expire
        86400 )  ; Minimum

@   IN  NS  ns1.$DOMAIN.
@   IN  NS  ns2.$DOMAIN.

3   IN  PTR erendis.$DOMAIN.
4   IN  PTR amdir.$DOMAIN.
EOF

chown root:bind /etc/bind/db.$DOMAIN /etc/bind/db.10.73.3
chmod 644 /etc/bind/db.$DOMAIN /etc/bind/db.10.73.3

if ! grep -q "$REVERSE_ZONE" /etc/bind/named.conf.local; then
    echo "zone \"$REVERSE_ZONE\" {
    type master;
    file \"/etc/bind/db.10.73.3\";
    allow-transfer { 10.73.3.4; };
};" >> /etc/bind/named.conf.local
fi

service bind9 restart
service bind9 enable
service bind9 status

echo "Erendis Update selesai. Serial: $SERIAL"
echo "  - WWW alias: www.$DOMAIN → $DOMAIN"
echo "  - PTR: 10.73.3.3 → erendis.$DOMAIN, 10.73.3.4 → amdir.$DOMAIN"
echo "  - TXT: 'Cincin Sauron' & 'Aliansi Terakhir' ditambahkan"