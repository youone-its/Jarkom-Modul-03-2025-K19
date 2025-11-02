#!/bin/bash

test_dns() {
    echo "[$1] $2"
    if dig @$1 $2 | grep -q "ANSWER: [1-9]"; then
        echo "OK"
    else
        echo "GAGAL"
    fi
    echo
}

test_dns 10.73.3.3 "www.k19.com"

test_dns 10.73.3.3 "-x 10.73.3.3"
test_dns 10.73.3.3 "-x 10.73.3.4"

test_dns 10.73.3.3 "elros.k19.com TXT"
test_dns 10.73.3.3 "pharazon.k19.com TXT"

echo "=== Verifikasi di Amdir (Slave) ==="
test_dns 10.73.3.4 "www.k19.com"
test_dns 10.73.3.4 "-x 10.73.3.3"
test_dns 10.73.3.4 "elros.k19.com TXT"

echo "Selesai. Jika semua, maka soal terpenuhi."