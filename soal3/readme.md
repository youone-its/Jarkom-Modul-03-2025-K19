Langkah 1: Pastikan Minastir Bisa Akses Internet
ping 8.8.8.8
curl -I http://google.com

kalo gagal
# Di Durin
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth5 -o eth0 -j ACCEPT

Langkah 2: Setup Minastir

Langkah 3: Setup Semua Client

chmod +x setup_client_proxy.sh
./setup_client_proxy.sh