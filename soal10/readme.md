Pastikan Elros Bisa Resolve Nama Worker
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

tambahin
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
di /etc/nginx/sites-available/elros-k19

jadi:

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

rm -f /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/elros-k19 /etc/nginx sites-enabled/
nginx -t
pkill nginx && nginx


di masing masing worker tambahin di nano /etc/nginx/sites-available/default
nginx -s reload

di masing masing worker bisa kasih edit:
nano /var/www/laravel/resources/views/welcome.blade.php
<p>elendil</p>
<p>isildur</p>
<p>anarion</p>

terus nginx -s reload

di client
# Pastikan DNS internal aktif
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

# Nonaktifkan proxy
unset http_proxy https_proxy

# Uji akses
lynx http://elros.k19.com
curl http://elros.k19.com/api/airing