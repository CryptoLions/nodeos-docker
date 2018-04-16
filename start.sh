#!/bin/bash
################################################################################
#
# Scrip prepared by http://CryptoLions.io
# https://github.com/CryptoLions/EOS-Jungle-Testnet
#
###############################################################################

WORKERSDIR="/opt/DockerJungleNet"
TAG="latest"
HTTP_PORT="8888:8888"
P2P_PORT="9876:9876"

docker service create --name nodeos --replicas 1 -p $HTTP_PORT -p $P2P_PORT --mount type=bind,source=$WORKERSDIR/"{{.Task.Slot}}",destination=/opt/eosio/bin/data-dir -t eosio/eos":"$TAG nodeosd.sh
