#!/bin/bash
#
# Build Synapse CDN WebACLs
#

set +x

# dev or prod
STACK=${1}

# prod, staging or tst
INSTANCE_ALIAS=${2}

# Folder containing source code
SRC_PATH=${3}

cd $SRC_PATH

mvn clean install

export CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK} -Dorg.sagebionetworks.org.instance=${INSTANCE_ALIAS}"

java $CMD_PROPS -Xms256m -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.cdn.webacl.CdnWebAclBuilderMain
