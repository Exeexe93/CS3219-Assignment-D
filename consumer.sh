#!/bin/bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e HOST_IP=consumer -e ZK=zookeeper:2181 -i -t --name=consumer wurstmeister/kafka /bin/bash
