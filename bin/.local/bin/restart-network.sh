#! /bin/bash
if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi
# Todo grep after active device
ip addr flush dev enp0s31f6
service networking --full-restart
