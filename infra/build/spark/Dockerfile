ARG BASE_CONTAINER=jupyter/scipy-notebook 
FROM $BASE_CONTAINER as notebook

LABEL maintainer="Magaiver Santos <magaiver.santos@universo.univates.br>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Spark dependencies
ARG spark_version="3.2.0"
ARG hadoop_version="3.2"
ENV APACHE_SPARK_VERSION="${spark_version}" \
    HADOOP_VERSION="${hadoop_version}"

RUN apt-get update --yes && \ 
    apt-get install --yes --no-install-recommends \
    ca-certificates-java && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Spark installation
WORKDIR /tmp
RUN wget -q "https://dlcdn.apache.org/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xzf "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    cd "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}"  && \
    ./bin/docker-image-tool.sh -u root -r magaiwer -t 3.2.4 -p kubernetes/dockerfiles/spark/bindings/python/Dockerfile build && \
    rm "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"

WORKDIR /opt/spark

RUN ln -s "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" spark && \
    # Add a link in the before_notebook hook in order to source automatically PYTHONPATH
    mkdir -p /usr/local/bin/before-notebook.d && \
    ln -s "${SPARK_HOME}/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh

# Fix Spark installation for Java 11 and Apache Arrow library
# see: https://github.com/apache/spark/pull/27356, https://spark.apache.org/docs/latest/#downloading
RUN cp -p "${SPARK_HOME}/conf/spark-defaults.conf.template" "${SPARK_HOME}/conf/spark-defaults.conf" && \
    echo 'spark.driver.extraJavaOptions -Dio.netty.tryReflectionSetAccessible=true' >> "${SPARK_HOME}/conf/spark-defaults.conf" && \
    echo 'spark.executor.extraJavaOptions -Dio.netty.tryReflectionSetAccessible=true' >> "${SPARK_HOME}/conf/spark-defaults.conf"

RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.94/aws-java-sdk-bundle-1.12.94.jar"
RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar"


USER ${NB_UID}

 # plugin spark monitor 
 RUN pip install \
    jupyterlab-sparkmonitor

# Install pyarrow
RUN mamba install --quiet --yes \
    'pyarrow' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

WORKDIR "${HOME}"
