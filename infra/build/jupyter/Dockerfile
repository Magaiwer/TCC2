FROM magaiwer/spark-py:3.2.1

LABEL maintainer="Magaiver Santos <magaiver.santos@universo.univates.br>"

RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt install -y --no-install-recommends \
    ffmpeg dvipng cm-super \
    wget \
    ca-certificates \
    ca-certificates-java \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*

# Bibliotecas adicionais para leitura e escrita no minI
RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.94/aws-java-sdk-bundle-1.12.94.jar"
RUN cd /opt/spark/jars \
 && wget "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.1/hadoop-aws-3.3.1.jar"

# Bibliotecas python e Jupyter Labs
RUN  pip install --no-cache-dir pyspark \ 
     jupyterhub \
     jupyterlab \
     ipynb \
     jupyterlab-sparkmonitor \
     altair \
     beautifulsoup4 \
     bokeh \
     bottleneck \
     cloudpickle \
     cython \
     dask \
     dill \
     h5py \
     ipympl\
     ipywidgets \
     numba \
     numexpr \
     pandas \
     patsy \
     protobuf \
     scikit-image \
     scikit-learn \
     scipy \
     seaborn \
     sqlalchemy \
     statsmodels \
     sympy \
     widgetsnbextension \
     pyarrow \
     xlrd \ 
     boto3 \
     minio 

VOLUME /home/notebook/

CMD jupyter lab --port=8888 --ip=0.0.0.0 --no-browser --allow-root --notebook-dir=/home/notebook/
