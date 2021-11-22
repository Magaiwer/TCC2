#!/bin/bash
docker build . -t magaiwer/spark-py:3.2.1
# tag image
docker tag magaiwer/spark-py:3.2.1 magaiwer/pyspark-notebook:3.2.1

# push image to registry
docker push magaiwer/pyspark-notebook:3.2.1
