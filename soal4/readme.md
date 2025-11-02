Langkah 1: Setup Erendis (Master)
Langkah 2: Setup Amdir (Slave)
Langkah 3: Verifikasi (Amdir)

# Di client (misal Amandil): set DNS
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

# Uji resolve
nslookup elendil.k19.com
ping palantir.k19.com