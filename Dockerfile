FROM openjdk:8

ENV JAVA_HOME /usr/local/openjdk-8
ENV SCALA_HOME /opt/work/scala-2.13.1
ENV SPARK_HOME /opt/work/spark-2.4.4-bin-hadoop2.7
ENV PATH="/opt/work/scala-2.13.1/bin:${PATH}"
ENV PATH="/opt/work/spark-2.4.4-bin-hadoop2.7/bin:${PATH}"

RUN apt-get update \
    && apt-get -y install ssh  \
    && apt-get -y install pdsh  \
    && mkdir -p /opt/work  \
    && cd /opt/work  \
    && wget https://downloads.lightbend.com/scala/2.13.1/scala-2.13.1.tgz \
    && tar -zxvf scala-2.13.1.tgz \ 
    && wget http://ftp.unicamp.br/pub/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz \
    && tar -zxvf spark-2.4.4-bin-hadoop2.7.tgz \
    && /opt/work/spark-2.4.4-bin-hadoop2.7/sbin/start-master.sh  \
    && /opt/work/spark-2.4.4-bin-hadoop2.7/sbin/start-slave.sh spark://$HOSTNAME:7077

CMD /opt/work/spark-2.4.4-bin-hadoop2.7/bin/spark-shell spark://$HOSTNAME:7077

# COMO RODAR
# docker build -t x . && docker run -it x
