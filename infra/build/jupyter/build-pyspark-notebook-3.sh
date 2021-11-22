docker build . -t magaiwer/spark-py:3.0.0
# tag image
docker tag magaiwer/spark-py:3.0.0 magaiwer/pyspark-notebook:3.0.0

# push image to registry
docker push magaiwer/pyspark-notebook:3.0.0
