#!/bin/bash

DIR="basedir"
#DIR=base.min

for i in {1..8}.
do
    if [ ! -d "$i" ]; then
      echo "coppying: $i"
      cp -R $DIR $i
    fi
done
