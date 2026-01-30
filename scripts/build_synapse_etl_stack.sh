#!/bin/bash
#
# Build Synapse Account ETL Stack
#

set +x

# dev or prod
STACK=${1}
# Glue database name
GLUE_DB=${2}

# Folder containing source code
SRC_PATH=${3}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.synapse.datawarehouse.glue.database.name=${GLUE_DB}"
export $CMD_PROPS

java $CMD_PROPS -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.datawarehouse.DataWarehouseBuilderMain
