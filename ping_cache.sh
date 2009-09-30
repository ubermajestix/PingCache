#!/bin/sh
broadcast_ip=`ifconfig | grep broadcast | cut -d " " -f6`
ping -c 2 ${broadcast_ip}
arp -a

