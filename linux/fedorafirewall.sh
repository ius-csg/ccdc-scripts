#!/bin/bash
systemctl stop firewalld
systemctl mask firewalld # Disable Fedora's preinstalled firewall
iptables -F # Flush all rules
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # Allow established connections
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # Allow incoming traffic to TCP port 80 (0.0.0.0:80)
iptables -A INPUT -p tcp --dport 25 -j ACCEPT # Allow incoming traffic to TCP port 25
iptables -A INPUT -p tcp --dport 110 -j ACCEPT # Allow incoming traffic to TCP port 110
iptables -I INPUT 1 -i lo -j ACCEPT # Allow traffic over the loopback interface (localhost)
sysctl -w net.ipv6.conf.all.disable_ipv6=1 # Kill IPv6
sysctl -w net.ipv6.conf.default.disable_ipv6=1
# Keep at end!
iptables -P INPUT DROP # Set default INPUT policy to DROP (Block)
iptables -P FORWARD DROP # Set default FORWARD policy to DROP (Block)
