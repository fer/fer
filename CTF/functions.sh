#!/bin/bash

# My CTF aliases

# Get network interface currently in use

getCurrentNetworkInterface() {
   ip addr | awk '/state UP/ {print $2}' | sed 's/.$//'
}

# Get IP assigned to the current network interface 
getCurrentIp() {
   CURRENT_IFACE=`getCurrentNetworkInterface`
   ifconfig $CURRENT_IFACE | grep 'inet ' | awk {'print $2'}
}

# Obtain tun0 ip address
iptun0() {
   ifconfig tun0 | grep 'inet ' | awk {'print $2'}
}