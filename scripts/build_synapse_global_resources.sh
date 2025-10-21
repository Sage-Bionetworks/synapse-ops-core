#!/bin/bash
#
# Build Synapse Account Global Resources (SES, IPs Pool, Synapse Help KB)
#

set +x

# dev, staging or prod
STACK=${1}

# the OPS VPC clouformation stack export prefix (e.g us-east-1-vpc in dev, us-east-1-synapse-ops-vpc-v2 in prod)
OPS_VPC_EXPORT_PREFIX=${2}

# Folder containing source code
SRC_PATH=${3}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.ops.export.prefix=${OPS_VPC_EXPORT_PREFIX}"
export $CMD_PROPS

java $CMD_PROPS -Xms256m -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.global.GlobalResourcesBuilderMain
