
#!/bin/bash
################################################################################
#
# Simple firewall by http://CryptoLions.io
# For allow access between servers in docker swarm cluster and 
# access to non producing node
# https://github.com/CryptoLions/EOS-Jungle-Testnet
#
###############################################################################

for iptables in "iptables" "ip6tables"
do
        # Drop all previous rules
        $iptables -F

        # Allow VNC (you could add a '-s 80.1.2.3' here, for example, to only allow connections from 80.1.2.3.
        #$iptables -A INPUT -p tcp --dport 5900 -j ACCEPT


if [ "$iptables" == 'ip6tables' ]; then
        # Filter all packets that have RH0 headers:
        $iptables -A INPUT -m rt --rt-type 0 -j DROP
        $iptables -A FORWARD -m rt --rt-type 0 -j DROP
        $iptables -A OUTPUT -m rt --rt-type 0 -j DROP
        # Allow Link-Local addresses
        $iptables -A INPUT -s fe80::/10 -j ACCEPT
        $iptables -A OUTPUT -s fe80::/10 -j ACCEPT
        # Allow multicast
        $iptables -A INPUT -d ff00::/8 -j ACCEPT
        $iptables -A OUTPUT -d ff00::/8 -j ACCEPT
        # Allow ICMPv6 everywhere
        $iptables -A INPUT  -p icmpv6 -j ACCEPT
        $iptables -A OUTPUT -p icmpv6 -j ACCEPT
        $iptables -A FORWARD -p icmpv6 -j ACCEPT
fi

        # Allow SSH
        $iptables -A INPUT -p tcp --dport 22 -j ACCEPT


        #Allow Web
        $iptables -A INPUT -p tcp --dport 80 -j ACCEPT
        $iptables -A INPUT -p tcp --dport 443 -j ACCEPT

        #docker swarm
        $iptables -A INPUT -p tcp --dport 2376 -j ACCEPT
        $iptables -A INPUT -p tcp --dport 2377 -j ACCEPT
        $iptables -A INPUT -p tcp --dport 7946 -j ACCEPT
        $iptables -A INPUT -p udp --dport 7946 -j ACCEPT
        $iptables -A INPUT -p udp --dport 4789 -j ACCEPT

        #nodeos: access to non-producing nodes
        $iptables -A INPUT -p tcp --dport 8888 -j ACCEPT
        $iptables -A INPUT -p tcp --dport 9876 -j ACCEPT


        # Allow loopback interface
        $iptables -A INPUT -i lo -j ACCEPT
        # Stateful so any connection initiated by the server is allowed
        $iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
        $iptables -A INPUT -p icmp -m conntrack --ctstate NEW -j ACCEPT
        $iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
        # Drop anything that doesn't match the above rules
        $iptables -A INPUT -j DROP
        $iptables -A FORWARD -j DROP
done
