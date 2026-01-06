#!/bin/bash
#
# Build Synapse stack in new VPC.
#

set +x

# example: jmhill
INSTANCE=${1}

# Folder containing source code
SRC_PATH=${2}

cd $SRC_PATH

mvn clean install

export CMD_PROPS=\
" -Dorg.sagebionetworks.stack=dev"\
" -Dorg.sagebionetworks.instance=${INSTANCE}"\
" -Dorg.sagebionetworks.vpc.subnet.color=Green"

java -Xms256m -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar \
$CMD_PROPS org.sagebionetworks.template.repo.RepositoryBuilderMain
