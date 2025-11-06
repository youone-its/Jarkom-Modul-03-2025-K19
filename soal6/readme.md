ubah /etc/dhcp/dhcpd.conf nya server dhcp jadi ada
buat 1.0:
default-lease-time 1800;
max-lease-time 3600;

buat 2.0:
default-lease-time 600;
max-lease-time 3600;

cat /var/lib/dhcp/dhclient.leases