FROM gettyimages/spark:2.0.0-hadoop-2.7

RUN echo "deb http://ftp.debian.org/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libsnappy-java \
    && rm -rf /var/lib/apt/lists/*

# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/hadoop-2.7.2/lib/native

WORKDIR $ZEPPELIN_HOME

RUN mkdir -p $ZEPPELIN_HOME \
    && curl http://ftp.nluug.nl/internet/apache/zeppelin/zeppelin-0.6.1/zeppelin-0.6.1-bin-netinst.tgz | tar xz -C $ZEPPELIN_HOME --strip-components=1 \
    && bin/install-interpreter.sh --name md,shell,cassandra,elasticsearch,angular,jdbc

CMD ["bin/zeppelin.sh"]