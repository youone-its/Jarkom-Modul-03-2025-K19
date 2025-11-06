#!/bin/bash
echo "Laravel Worker Starting setup..."

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt update

echo "Laravel Worker Installing base tools..."
apt install -y lsb-release ca-certificates apt-transport-https gnupg2 curl wget

echo "Laravel Worker Adding PHP 8.4 repository..."
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

echo "Laravel Worker Installing PHP 8.4 and extensions..."
apt update
apt install -y php8.4 php8.4-fpm php8.4-cli php8.4-mbstring php8.4-xml php8.4-curl php8.4-zip php8.4-sqlite3

echo "Laravel Worker Installing Nginx..."
apt install -y nginx

echo "Laravel Worker Installing Composer..."
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

echo "Laravel Worker Installing Git..."
apt install -y git

echo "Laravel Worker Cloning Laravel app..."
cd /var/www
rm -rf laravel laravel-simple-rest-api
git clone https://github.com/elshiraphine/laravel-simple-rest-api.git laravel

echo "Laravel Worker Installing Laravel dependencies..."
cd laravel
composer update --no-dev --optimize-autoloader
composer install --no-dev --optimize-autoloader

echo "Laravel Worker Configuring .env..."
cp .env.example .env
php artisan key:generate

echo "Laravel Worker Setting permissions..."
chown -R www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 775 /var/www/laravel/storage /var/www/laravel/bootstrap/cache

echo "Laravel Worker Configuring Nginx..."
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80;
    server_name _;

    root /var/www/laravel/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

echo "Laravel Worker Starting services..."
service php8.4-fpm start
service nginx start

echo "Laravel Worker Reloading Nginx..."
nginx -t