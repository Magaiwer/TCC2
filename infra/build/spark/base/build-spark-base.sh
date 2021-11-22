#!/bin/bash
# Download do spark com hadoop
rm -rf spark-3.2.0-bin-hadoop3.2*
wget https://dlcdn.apache.org/spark/spark-3.2.0/spark-3.2.0-bin-hadoop3.2.tgz
tar xvzf spark-3.2.0-bin-hadoop3.2.tgz
cd spark-3.2.0-bin-hadoop3.2

# construção da imagem spark 
./bin/docker-image-tool.sh -u root -r magaiwer -t 3.2.1 -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile build

# envio para o dockerhub
docker push magaiwer/spark-py:3.2.1

rm -rf spark-3.2.0-bin-hadoop3.2*