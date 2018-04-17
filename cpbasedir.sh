#!/bin/bash
################################################################################
#
# Scrip by http://CryptoLions.io
# https://github.com/CryptoLions/
# use peerlist in DIR as source
# Copy to COUNT Dirs 1..COUNT
###############################################################################

DIR="basedir"
COUNT=1
SERVER_ADDR="0.0.0.0:9876"

readarray peers < $DIR/peerlist.ini
tot_peers=${#peers[@]}
one_grp_c=$((tot_peers/COUNT))


for ((i=1; i<=COUNT; i++))
do
    peersSTR=""
    for ((k=0; k<one_grp_c; k++))
    do
        idx=$(($(($i-1))*$one_grp_c+$k))
        peersSTR=$peersSTR"\n"${peers[idx]}
    done


    addConfig="\n\np2p-server-address = $SERVER_ADDR \n$peersSTR"

    echo -ne $addConfig

    if [ ! -d "$i" ]; then
      echo "coppying: $i"
      cp -R $DIR $i
    fi
    cp $DIR/config.ini $i/config.ini

    echo -ne $addConfig >> $i/config.ini
done
