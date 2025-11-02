# Arsitektur Númenor - Solusi Lengkap dari Awal

## Komponen
- **Palantir**: Database Server (MariaDB)
- **Elendil/Isildur/Anarion**: Laravel Workers (Port 8001-8003)
- **Elros**: Load Balancer (Round Robin)
- **Client**: Amandil, Gilgalad (untuk testing)

## Prasyarat Topologi
- Prefix IP: `10.73.0.0/16`
- DNS: `k19.com` (Erendis = `10.73.3.3`, Amdir = `10.73.3.4`)
- Semua node non-router menggunakan DNS internal

## Cara Penggunaan

### 1. Setup Database
```bash
# Di Palantir (10.73.4.3)
chmod +x palantir/setup_palantir.sh
./palantir/setup_palantir.sh

2. Setup Worker Laravel
# Di Elendil (10.73.1.2)
chmod +x workers/setup_elendil.sh
./workers/setup_elendil.sh

# Di Isildur (10.73.1.3)
chmod +x workers/setup_isildur.sh
./workers/setup_isildur.sh

# Di Anarion (10.73.1.4)
chmod +x workers/setup_anarion.sh
./workers/setup_anarion.sh

3. Jalankan Migrasi (Hanya di Elendil!)
cd /var/www/laravel-simple-rest-api
php artisan migrate --seed

4. Setup Load Balancer
# Di Elros (10.73.1.6)
chmod +x elros/setup_elros.sh
./elros/setup_elros.sh

5. Setup Client
# Di Amandil/Gilgalad
chmod +x client/setup_client.sh
./client/setup_client.sh

6. Verifikasi
# Akses individual worker
lynx http://elendil.k19.com:8001
curl http://elendil.k19.com:8001/api/airing

# Akses via Load Balancer
lynx http://laravel.k19.com
curl http://laravel.k19.com/api/airing

# Load testing
ab -n 100 -c 10 http://laravel.k19.com/