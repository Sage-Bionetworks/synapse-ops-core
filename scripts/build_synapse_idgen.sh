#!/bin/bash
#
# Build Synapse Account ID Generator
#

set +x

# dev or prod
STACK=${1}
# VPC subnet color
VPC_SUBNET_COLOR=${2}
# ID generator hosted zone ID
IDGEN_HOSTED_ZONE_ID=${3}

# Folder containing source code
SRC_PATH=${4}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.subnet.color=${VPC_SUBNET_COLOR}"
CMD_PROPS+=" -Dorg.sagebionetworks.id.generator.hosted.zone.id=${IDGEN_HOSTED_ZONE_ID}"
export $CMD_PROPS

java $CMD_PROPS -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.repo.IdGeneratorMain
