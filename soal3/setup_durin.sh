#!/bin/bash

iptables -A FORWARD -i eth5 -o eth0 -j ACCEPT
