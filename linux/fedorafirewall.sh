#!/bin/bash
 Not COMPLETE!
systemctl mask firewalld
iptables -F
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -i lo -j ACCEPT # loopback
sysctl -w net.ipv6.conf.all.disable_ipv6=1 # Kill IPv6
sysctl -w net.ipv6.conf.default.disable_ipv6=1
# Keep at end!
iptables -P INPUT DROP
iptables -P FORWARD DROP
