#!/bin/bash
# Installs AIDE on the current Linux system using package management
# Must be run as root
if [ -e /usr/bin/apt-get ]; then #Check path for APT later
    apt-get install aide -y
    elif [ -e /usr/bin/yum ]; then #CentOS
    yum -y install aide
    elif [ -e /usr/bin/dnf ]; then #Fedora
    dnf -y install aide
else
    echo "Unknown OS, you are on your own. Good luck."
    exit 1
fi

# Setup config and run
if [ -e /var/lib/aide/aide.db.gz ]; then
    echo "Updating database..."
    aide --update
else
    aide --init
fi
mv -vf /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
echo "Running check..."
aide --check
