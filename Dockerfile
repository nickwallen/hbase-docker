#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM centos:7
MAINTAINER dev@metron.apache.org

ENV HDP_REPO_URL=http://public-repo-1.hortonworks.com/HDP/centos7/3.x/updates/3.1.0.0/hdp.repo

# hbase master
ENV HBASE_MASTER_HOSTNAME=localhost
ENV HBASE_MASTER_PORT=16000
ENV HBASE_MASTER_WEB_PORT=16010

# hbase regionserver
ENV HBASE_REGION_SERVER_HOSTNAME=localhost
ENV HBASE_REGION_SERVER_PORT=16020
ENV HBASE_REGION_SERVER_WEB_PORT=16030

# embedded zookeeper
ENV HBASE_ZOOKEEPER_QUORUM=localhost
ENV HBASE_ZOOKEEPER_PORT=2181

ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
ENV HBASE_HOME=/usr/hdp/current/hbase-client
ENV HBASE_SITE_PATH=/etc/hbase/conf/hbase-site.xml
ENV HADOOP_HDFS_HOME=/usr/hdp/current/hadoop-hdfs-client

# export ports
EXPOSE ${HBASE_ZOOKEEPER_PORT}
EXPOSE ${HBASE_MASTER_PORT}
EXPOSE ${HBASE_MASTER_WEB_PORT}
EXPOSE ${HBASE_REGION_SERVER_PORT}
EXPOSE ${HBASE_REGION_SERVER_WEB_PORT}

# install HBase
RUN yum install -y wget \
  && wget ${HDP_REPO_URL} -P /etc/yum.repos.d/ \
  && yum updateinfo \
  && yum -y update \
  && yum install -y \
    hbase \
    java-1.8.0-openjdk-devel \
    sudo \
  && yum clean all

# add required dependency, which is missing by default in HDP 3.1
RUN cp ${HADOOP_HDFS_HOME}/hadoop-hdfs-client.jar ${HBASE_HOME}/lib/

COPY hbase-site.xml.template .
COPY start.sh .
RUN chmod 755 start.sh
CMD [ "./start.sh" ]
