#!/bin/sh
ifconfig | grep broadcast | cut -d " " -f6 | xargs -0 ping -c2; 
arp -a | cut -d" " -f4
