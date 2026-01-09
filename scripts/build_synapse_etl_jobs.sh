#!/bin/bash
#
# Build Synapse Account ETL Jobs
#

set +x

# dev or prod
STACK=${1}

# Folder containing source code
SRC_PATH=${2}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
export $CMD_PROPS

java $CMD_PROPS -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.etl.EtlBuilderMain
