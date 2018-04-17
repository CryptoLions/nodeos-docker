#!/bin/bash
################################################################################
#
# Simple firewall by http://CryptoLions.io
# For allow access between servers in docker swarm cluster and.
# access to non producing node
# https://github.com/CryptoLions/EOS-Jungle-Testnet
#
###############################################################################

$iptables -A INPUT -p tcp --dport 8888 -j ACCEPT
$iptables -A INPUT -p tcp --dport 9876 -j ACCEPT


iptables -I DOCKER-USER -i eth0 -p tcp --dport 3888 -j DROP
iptables -I DOCKER-USER -i eth0 -p tcp --dport 4876 -j DROP

#docker swarm
iptables -A INPUT -p tcp --dport 2376 -j ACCEPT
iptables -A INPUT -p tcp --dport 2377 -j ACCEPT
iptables -A INPUT -p tcp --dport 7946 -j ACCEPT
iptables -A INPUT -p udp --dport 7946 -j ACCEPT
iptables -A INPUT -p udp --dport 4789 -j ACCEPT
