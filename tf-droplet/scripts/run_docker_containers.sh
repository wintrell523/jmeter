#!/bin/bash

echo 'Starting the containers'
echo 'Starting elasticsearch'
docker run --name elasticsearch --net perf --rm -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.8.13 bin/elasticsearch -Enetwork.host=0.0.0.0
echo 'Starting kibana'
docker run --name kibana --net perf --rm -d -p 5601:5601 docker.elastic.co/kibana/kibana:6.8.13
echo 'Starting jmeter'
docker run --name jmeter --net perf -d -it -v `pwd`:/tests --rm -p 5901:5901 rdpanek/jmeter:vnc-5.3.0
echo 'Done'