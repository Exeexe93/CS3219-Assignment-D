#!/bin/bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e HOST_IP=producer -e ZK=zookeeper:2181 -i -t --name=producer wurstmeister/kafka /bin/bash
