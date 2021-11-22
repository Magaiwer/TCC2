#!/bin/bash
#rm -rf spark-3.0.0-bin-hadoop2.7*
#wget https://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop2.7.tgz
#tar xvzf spark-3.0.0-bin-hadoop2.7.tgz
cd spark-3.0.0-bin-hadoop2.7

./bin/docker-image-tool.sh -u root -r magaiwer -t 3.0.0 -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

# push image to registry
docker push magaiwer/spark-py:3.0.0

#rm -rf spark-3.0.0-bin-hadoop2.7*