#!/usr/bin/env bash
#################################
#
# Created by Eos.io
# Updated by CryptoLions.io
#
##################################
set -x

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -SIGTERM "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

trap 'kill ${!}; term_handler' SIGTERM


cd /opt/eosio/bin

if [ -f '/opt/eosio/bin/data-dir/config.ini' ]; then
    echo
  else
    cp /config.ini /opt/eosio/bin/data-dir
fi

if [ -f '/opt/eosio/bin/data-dir/genesis.json' ]; then
    echo
  else
    cp /genesis.json /opt/eosio/bin/data-dir
fi

if [ -d '/opt/eosio/bin/data-dir/contracts' ]; then
    echo
  else
    cp -r /contracts /opt/eosio/bin/data-dir
fi

while :; do
    case $1 in
        --config-dir=?*)
            CONFIG_DIR=${1#*=}
            ;;
        *)
            break
    esac
    shift
done

if [ ! "$CONFIG_DIR" ]; then
    CONFIG_DIR="--data-dir=/opt/eosio/bin/data-dir --config-dir=/opt/eosio/bin/data-dir"
else
    CONFIG_DIR=""
fi

/opt/eosio/bin/nodeos --shared-memory-size-mb 4096 $CONFIG_DIR > /opt/eosio/bin/data-dir/nodeos_out.log 2> /opt/eosio/bin/data-dir/nodeos_err.log &

pid="$!"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done
