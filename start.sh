#!/bin/bash
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
set -u

HBASE_HOME=/usr/hdp/current/hbase-client
HBASE_CONF=${HBASE_HOME}/conf
HBASE_SITE=${HBASE_CONF}/hbase-site.xml
HBASE_SITE_TEMPLATE=hbase-site.xml.template

echo "HBase Master @ ${HBASE_MASTER_HOSTNAME}:${HBASE_MASTER_PORT}"
echo "HBase Master Info @ http://${HBASE_MASTER_HOSTNAME}:${HBASE_MASTER_WEB_PORT}"
echo "Hbase Regionserver @ ${HBASE_REGION_SERVER_HOSTNAME}:${HBASE_REGION_SERVER_PORT}"
echo "HBase Regionserver Info @ http://${HBASE_REGION_SERVER_HOSTNAME}:${HBASE_REGION_SERVER_WEB_PORT}"
echo "Zookeeper @ ${HBASE_ZOOKEEPER_QUORUM}:${HBASE_ZOOKEEPER_PORT}"

# define hbase-site.xml using the template and environment variables
envsubst < ${HBASE_SITE_TEMPLATE} > ${HBASE_SITE}

# start HBase master
${HBASE_HOME}/bin/hbase --config ${HBASE_CONF} master start
