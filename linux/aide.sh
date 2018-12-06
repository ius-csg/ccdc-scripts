#!/bin/bash
# Installs AIDE on the current Linux system using package management
# Must be run as root
which apt-get
if [ $? == 0] then;
apt-get install aide -y
fi
