Menyiapkan lingkungan web dinamis di tiga node worker:
- Elendil (`10.73.1.2`)
- Isildur (`10.73.1.3`)
- Anarion (`10.73.1.4`)

Setiap worker menjalankan halaman PHP dinamis dengan Nginx + PHP 8.4-FPM.

- DNS internal (`k19.com`) sudah berjalan (Erendis & Amdir)
- Jaringan antar node berfungsi


Jalankan di Elendil, Isildur, dan Anarion:
```bash
chmod +x setup_worker.sh
./setup_worker.sh
chmod +x setup_client.sh
./setup_client.sh

3. Uji Akses
Dari client, uji masing-masing worker:
lynx http://elendil.k19.com
lynx http://isildur.k19.com
lynx http://anarion.k19.com