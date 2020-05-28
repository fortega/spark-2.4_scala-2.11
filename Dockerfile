FROM openjdk:8-jre-slim

ENV SPARK_VERSION=2.4.5

WORKDIR /root

# Tini
RUN apt update -y && apt install -y tini wget && apt clean

# Spark
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz && \
    tar -xzvf spark-${SPARK_VERSION}-bin-hadoop2.7.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop2.7 spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop2.7.tgz && \
    rm -rf spark/examples spark/kubernetes && \
    wget https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop2-latest.jar && mv gcs-connector-hadoop2-latest.jar spark/jars && \
    echo export SPARK_DIST_CLASSPATH=$($HOME/hadoop/bin/hadoop classpath) | tee -a $HOME/spark/conf/spark-env.sh && chmod +x $HOME/spark/conf/spark-env.sh

# Configuration
COPY conf/spark-defaults.conf spark/conf/

# Start spark to cache packages
RUN spark/bin/spark-submit spark/jars/ivy-2.4.0.jar; echo

ENTRYPOINT [ "tini", "--" ]

COPY start.bash .

CMD ["bash","start.bash"]