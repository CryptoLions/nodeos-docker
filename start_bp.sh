#!/bin/bash
################################################################################
#
# Scrip prepared by http://CryptoLions.io
# https://github.com/CryptoLions/EOS-Jungle-Testnet
#
###############################################################################

WORKERSDIR="/opt/DockerJungleNet"
TAG="v300"
HTTP_PORT="3888:3888"
P2P_PORT="4876:4876"

docker service create --name nodeos_bp --replicas 1 -p $HTTP_PORT -p $P2P_PORT --mount type=bind,source=$WORKERSDIR/producer,destination=/opt/eosio/bin/data-dir -t eosio/eos":"$TAG nodeosd.sh



