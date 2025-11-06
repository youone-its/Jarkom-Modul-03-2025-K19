#!/bin/bash

echo "nameserver 10.73.3.3" >> /etc/resolv.conf
echo "nameserver 10.73.3.4" >> /etc/resolv.conf
ping palantir.k19.com