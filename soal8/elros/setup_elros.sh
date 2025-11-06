#!/bin/bash

echo "Elros Installing Nginx..."
apt update
apt install -y nginx

echo "nameserver 192.168.122.1" > /etc/resolv.conf
echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

cat > /etc/nginx/sites-available/laravel-lb <<'EOF'
upstream laravel_workers {
    server elendil.k19.com:8001;
    server isildur.k19.com:8002;
    server anarion.k19.com:8003;
}

server {
    listen 80;
    server_name laravel.k19.com;

    location / {
        proxy_pass http://laravel_workers;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF

rm -f /etc/nginx/sites-enabled/*
ln -sf /etc/nginx/sites-available/laravel-lb /etc/nginx/sites-enabled/default

service nginx restart
nginx -t && service nginx reload

echo "Elros Load Balancer ready! Access via: http://laravel.k19.com"