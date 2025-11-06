#!/bin/bash

echo "Elendil Installing dependencies..."
apt update
apt install -y lsb-release ca-certificates apt-transport-https gnupg2 curl git wget

curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

apt update
apt install -y php8.4 php8.4-fpm php8.4-cli php8.4-mbstring php8.4-xml php8.4-curl php8.4-mysql nginx

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

cd /var/www
rm -rf laravel-simple-rest-api
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git laravel
cd laravel

composer update --no-dev --optimize-autoloader

cp .env.example .env
sed -i "s/DB_HOST=127.0.0.1/DB_HOST=palantir.k19.com/" .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=numenor_db/" .env
sed -i "s/DB_USERNAME=root/DB_USERNAME=ksatria/" .env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=rahasia/" .env
php artisan key:generate

chown -R www-data:www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 775 /var/www/laravel/storage /var/www/laravel/bootstrap/cache

cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 8002 default_server;
    listen [::]:8002 default_server;
    server_name "";
    return 444;
}

server {
    listen 8002;
    server_name isildur.k19.com localhost laravel.k19.com;

    root /var/www/laravel/public;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

service php8.4-fpm start
service nginx start
nginx -t && service nginx reload

echo "Elendil Setup complete! Access via: http://isildur.k19.com:8002"