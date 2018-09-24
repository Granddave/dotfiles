#! /bin/bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

for i in $(ls /sys/class/net/) ; do
    /sbin/ip addr flush $i &
done
service networking --full-restart
