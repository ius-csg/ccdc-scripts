#!/bin/bash
for service in /etc/init.d/*; do if [[ $(basename $service) != "iptables" ]]; then sudo service $(basename $service) status | grep "is running"; fi; done
