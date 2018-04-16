#!/bin/bash

docker service create --name nodeos --replicas 1 -p 8888:8888 -p 9876:9876 --mount type=bind,source=/opt/DockerJungleNet/"{{.Task.Slot}}",destination=/opt/eosio/bin/data-dir -t eosio/eos nodeosd.sh
