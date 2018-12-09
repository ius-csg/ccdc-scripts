#!/bin/bash

# Install artillery and tmux if specified
#TODO: Test script and duplicate port honeypots
OPTIND=1
# Specify -t to install tmux
while getopts 't' opt; do
    if [ opt == t ]; then
        if [ -e /usr/bin/apt-get ]; then #Check path for APT later
            apt-get install tmux -y
            elif [ -e /usr/bin/yum ]; then #CentOS
            yum -y install tmux
            elif [ -e /usr/bin/dnf ]; then #Fedora
            dnf -y install tmux
        else
            echo "Unknown OS, cannot install tmux via package management"
        fi
    fi
done
shift "$((OPTIND-1))"
wget -q https://github.com/BinaryDefense/artillery/archive/master.zip

if [ $? != 0 ]; then
    curl https://github.com/BinaryDefense/artillery/archive/master.zip
fi
unzip master.zip
cd artillery-master
# Let's not automodify the firewall
sed -i 's/HONEYPOT_AUTOACCEPT="ON"/HONEYPOT_AUTOACCEPT="OFF"/g' config 
if [ $opt == t ]; then
    tmux
    tmux attach \;  new-window python artillery.py
fi
python artillery.py &