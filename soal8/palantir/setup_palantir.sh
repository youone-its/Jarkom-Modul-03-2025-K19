#!/bin/bash

echo "Palantir Installing MariaDB..."
apt update
apt install -y mariadb-server

sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb restart

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS numenor_db;
CREATE USER 'ksatria'@'%' IDENTIFIED BY 'rahasia';
GRANT ALL PRIVILEGES ON numenor_db.* TO 'ksatria'@'%';
FLUSH PRIVILEGES;
EOF

echo "Palantir Database ready! User: ksatria / Password: rahasia"