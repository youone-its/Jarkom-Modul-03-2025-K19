di client dipasangin
apt install -y apache2-utils htop

echo "nameserver 10.73.3.3" > /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf

unset http_proxy https_proxy

ters uji pake
ab -n 100 -c 10 http://elros.k19.com/api/airing/ 
abistu
ab -n 2000 -c 100 http://elros.k19.com/api/airing/

(bakal keliatan seberapa brutal kalo ab -n 2000 -c 100 http://elros.k19.com/api/airing/)

# di elros
jadiin kaya gini:
server elendil.k19.com:8001 weight=3;
    server isildur.k19.com:8002 weight=1;
    server anarion.k19.com:8003 weight=1;

nginx -s reload

dari client ditest lagi
ab -n 2000 -c 100 http://elros.k19.com/api/airing/
