# JARKOM MODUL 3
---
## Soal 1
- Durin
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.73.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.73.2.1
    netmask 255.255.255.0

auto eth3
iface eth3 inet static
    address 10.73.3.1
    netmask 255.255.255.0

auto eth4
iface eth4 inet static
    address 10.73.4.1
    netmask 255.255.255.0

auto eth5
iface eth5 inet static
    address 10.73.5.1
    netmask 255.255.255.0
```
- Aldarion
```
auto eth0
iface eth0 inet static
    address 10.73.4.2
    netmask 255.255.255.0
    gateway 10.73.4.1

up echo nameserver 192.168.122.1 > /etc/resolv.conf
```  
- Amandil dan Gilfald dan Khamul
```
auto eth0
iface eth0 inet dhcp
```
- Minastir
```
auto eth0
iface eth0 inet static
    address 10.73.5.2
    netmask 255.255.255.0
    gateway 10.73.5.1

up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Erendis
```
auto eth0
iface eth0 inet static
    address 10.73.3.3
    netmask 255.255.255.0
    gateway 10.73.3.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Amdir
```
auto eth0
iface eth0 inet static
    address 10.73.3.4
    netmask 255.255.255.0
    gateway 10.73.3.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Elendil
```
auto eth0
iface eth0 inet static
    address 10.73.1.2
    netmask 255.255.255.0
    gateway 10.73.1.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Isildur
```
auto eth0
iface eth0 inet static
    address 10.73.1.3
    netmask 255.255.255.0
    gateway 10.73.1.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Anarion
```
auto eth0
iface eth0 inet static
    address 10.73.1.4
    netmask 255.255.255.0
    gateway 10.73.1.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Palantir
```
auto eth0
iface eth0 inet static
    address 10.73.4.3
    netmask 255.255.255.0
    gateway 10.73.4.1

up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Elros
```
auto eth0
iface eth0 inet static
    address 10.73.1.6
    netmask 255.255.255.0
    gateway 10.73.1.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Miriel
```
auto eth0
iface eth0 inet static
    address 10.73.1.5
    netmask 255.255.255.0
    gateway 10.73.1.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Narvi
```
auto eth0
iface eth0 inet static
    address 10.73.4.4
    netmask 255.255.255.0
    gateway 10.73.4.1

up echo nameserver 192.168.122.1 > /etc/resolv.conf
```
- Pharazon
```
auto eth0
iface eth0 inet static
    address 10.73.2.3
    netmask 255.255.255.0
    gateway 10.73.2.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Celebrimbor
```
auto eth0
iface eth0 inet static
    address 10.73.2.2
    netmask 255.255.255.0
    gateway 10.73.2.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Galadriel
```
auto eth0
iface eth0 inet static
    address 10.73.2.4
    netmask 255.255.255.0
    gateway 10.73.2.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Celeborn
```
auto eth0
iface eth0 inet static
    address 10.73.2.5
    netmask 255.255.255.0
    gateway 10.73.2.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- Oropher
```
auto eth0
iface eth0 inet static
    address 10.73.2.5
    netmask 255.255.255.0
    gateway 10.73.2.1

up echo nameserver 192.168.122.1 >  /etc/resolv.conf
```
- di durin: iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0

---

## Soal 2
```
Soal 2 ini berfokus pada menyiapkan dhcp client, dhcp server, dan dhcp relay.
dhcp relay digunakan karna dhcp client berada di subnet yang berbeda dengan dhcp server,
maka perlu adanya sesuatu yang meneruskan ip dhcp ke dhcp client
```
### di durin:
- set iptables -t nat -A POSTROUTING -j MASQUERADE -o eth0,
- jalankan soal2/setup_durin.sh
### di Aldarion
- jalankan soal2/setup_alderion.sh
### di Amandil
- jalankan soal2/setup_client1.sh
### di Gilgald
- jalankan soal2/setup_client2.sh

## Soal 3
```
Di soal 3 ini request soal adalah untuk membuat semua akses ke luar itu dicek
terlebih dahulu melalui minastir, maka minastir diset sebagai forward proxy menggunakan squid
```
### Di Minastir
```
Langkah 1: Pastikan Minastir Bisa Akses Internet
ping 8.8.8.8
curl -I http://google.com
```
jika gagal, maka di *Durin* perlu
```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth5 -o eth0 -j ACCEPT
```
### di Minastir
- jalankan soal3/setup_minastir.sh
### di Client, bebas
- jalankan soal3/setup_client_proxy.sh
- cek apakah ada minastir di reply nya

## Soal 4
```
Dis soal 4 ini, praktikan diminta untuk membuat domain name server, maka saya set, sesuai soal, erendis
sebagai master dan amdir sebagai slave server. dns ini nantinya dipakai pada soal terkait website
```
### di erendis
- jalankan soal4/setup_erendis.sh
### di amdir
- jalankan soal4/setup_amdir.sh
### untuk cek hasil setup dns, maka di client, bebas
- jalankan soal4/setup_client

## Soal 5
```
Soal lanjutan dari soal 4 dimana praktikan diminta untuk membuat reverse proxy dari dns nya,
serta memberikan pesan rahasia di alamat pharazon dan elros
```
### di erendis
- jalankan soal5/update_erendis.sh
### di amdir
- jalankan soal5/update_amdir.sh
### untuk cek hasil setup dns, maka di client, bebas
- jalankan soal5/verify_dns

## Soal 6
```
Soal meminta untuk di dhcp server dijadikan dynamic ip, maka untuk yang Amandil dan Gilgald diberikan
lease time sesuai ketentuan soal, Amandil diberikan default-lease-time 1800, dengan max-lease-time 3600
sedangkan gilgald diberikan default-lease-time 600 dan max-lease-time 3600.

Tidak ada bash script di sini karena hanya perlu ubah sedikit di Aldarion: /etc/dhcp/dhcpd.conf

dan cek menggunakan cat /var/lib/dhcp/dhclient.leases
```

## Soal 7
```
Soal meminta untuk menjadikan
- Elendil (`10.73.1.2`)
- Isildur (`10.73.1.3`)
- Anarion (`10.73.1.4`)
sebagai lingkungan web dinamis

Setiap worker menjalankan halaman PHP dinamis dengan Nginx + PHP 8.4-FPM.
- DNS internal (`k19.com`) sudah berjalan (Erendis & Amdir)
- Jaringan antar node berfungsi
```
### Jalankan di Elendil, Isildur, dan Anarion:
- soal7/setup_worker
### Tes di client 
- soal7/setup_client

## Soal 8
```
Setiap benteng Númenor harus terhubung ke sumber pengetahuan, Palantir. Konfigurasikan koneksi database
di file .env masing-masing worker. Setiap benteng juga harus memiliki gerbang masuk yang unik; atur nginx
agar Elendil mendengarkan di port 8001, Isildur di 8002, dan Anarion di 8003. Jangan lupa jalankan
migrasi dan seeding awal dari Elendil. Buat agar akses web hanya bisa melalui domain nama, tidak bisa
melalui ip.

soal ini meminta agar akses ke worker hanya bisa melalui domain name, dan bukan lewat ip saja.
Kemudian untuk masing masing worker itu dijalankan di port masing masing, elendil 8001, isildur 8002, anarion 8003
```
### di palantir
- jalankan soal8/palantir/setup_palantir
```
palantir ini setup database nya
kita bikin db numenor_db, user kesatria, dan kasih permission ke kesatria untuk kemudian dimasukkan ke environment
masing masing laravel worker
```
### di worker
```
di masing masing worker nya kita setup nginx nya, setup mana file yang ditampilkan, dan nyalakan service nya
```
### di elendil
- jalankan soal8/worker/setup_elendil
### di isildur
- jalankan soal8/worker/setup_isildur
### di anarion
- jalankan soal8/worker/setup_anarion

### jalankan migrasi
```
cd /var/www/laravel-simple-rest-api
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
php artisan migrate --seed
```
### di elros
```
elros sebagai load balancer disetup untuk bisa dipanggil dengan nginx (selanjutnya akan menjadi load balancer dengan round robin)
```
- jalankan soal8/elros/setup_elros

### di client
- lakukan hal yang ada di soal8/client/setup_client (lynx)
---

## Soal 9
```
Pastikan setiap benteng berfungsi secara mandiri. Dari dalam node client masing-masing, gunakan lynx untuk melihat
halaman utama Laravel dan curl /api/airing untuk memastikan mereka bisa mengambil data dari Palantir.

kita setup / update untuk ownership dan permission mode nya ke path yang punya /api/airing
```
### di palantir
- jalankan soal8/palantir/setup_palantir
```
palantir ini setup database nya
kita bikin db numenor_db, user kesatria, dan kasih permission ke kesatria untuk kemudian dimasukkan ke environment
masing masing laravel worker
```
### di worker
```
di masing masing worker nya kita setup nginx nya, setup mana file yang ditampilkan, dan nyalakan service nya
```
### di elendil
- jalankan soal8/worker/setup_elendil
### di isildur
- jalankan soal8/worker/setup_isildur
### di anarion
- jalankan soal8/worker/setup_anarion

### jalankan migrasi
```
cd /var/www/laravel-simple-rest-api
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
php artisan migrate --seed
```

### di elros
```
elros sebagai load balancer disetup untuk bisa dipanggil dengan nginx
(selanjutnya akan menjadi load balancer dengan round robin)
```
- jalankan soal8/elros/setup_elros

### di client
- lakukan hal yang ada di soal8/client/setup_client (lynx, curl)

```
ini cara implementasi nya sama seperti soal 8, hanya beda di chown dan chmod (tapi ini eror)
```
---

## Soal 10
Pastikan Elros Bisa Resolve Nama Worker
```
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
```
tambahin
```
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
```
di /etc/nginx/sites-available/elros-k19

jadi:
```
upstream kesatria_numenor {
    server elendil.k19.com:8001;
    server isildur.k19.com:8002;
    server anarion.k19.com:8003;
}

server {
    listen 80;
    server_name elros.k19.com;

    location / {
        proxy_pass http://kesatria_numenor;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}
```
```
rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/elros-k19 /etc/nginx sites-enabled/
nginx -t
pkill nginx && nginx
```
di masing masing worker tambahin di nano /etc/nginx/sites-available/default
[nginx -s reload]

di masing masing worker bisa kasih edit:
nano /var/www/laravel/resources/views/welcome.blade.php
<p>elendil</p>
<p>isildur</p>
<p>anarion</p>

terus 

[nginx -s reload]

di client
Pastikan DNS internal aktif
```
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
```
Nonaktifkan proxy
```
unset http_proxy https_proxy
```
Uji akses
```
lynx http://elros.k19.com
curl http://elros.k19.com/api/airing
```

```
Karna di soal sebelumnya ada eror, maka di soal 10 dan 11 tidak bisa jalan,
karna load balancer perlu ketiga worker aktif agar tidak eror
```
---

## Soal 11
di client dipasangin
```
apt install -y apache2-utils htop
```
```
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
```
```
unset http_proxy https_proxy
```

ters uji pake
```
ab -n 100 -c 10 http://elros.k19.com/api/airing/ 
```
abistu
```
ab -n 2000 -c 100 http://elros.k19.com/api/airing/
```
(bakal keliatan seberapa brutal kalo ab -n 2000 -c 100 http://elros.k19.com/api/airing/)

di elros
jadiin kaya gini:
```
  server elendil.k19.com:8001 weight=3;
  server isildur.k19.com:8002 weight=1;
  server anarion.k19.com:8003 weight=1;
```
```
nginx -s reload
```
dari client ditest lagi
```
ab -n 2000 -c 100 http://elros.k19.com/api/airing/
```
