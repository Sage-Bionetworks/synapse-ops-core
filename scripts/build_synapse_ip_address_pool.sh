#!/bin/bash
#
# Build Synapse Account IP Address Pool
#

set +x

# dev or prod
STACK=${1}
# NLB records csv
NLB_RECORDS_CSV=${2}
# Availability zones per NLB
AZ_PER_NLB=${3}


# Folder containing source code
SRC_PATH=${4}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.nlb.record.csv=${NLB_RECORDS_CSV}"
CMD_PROPS+=" -Dorg.sagebionetworks.ip.address.pool.number.az.per.nlb=${AZ_PER_NLB}"
export $CMD_PROPS

java $CMD_PROPS -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.ip.address.IpAddressPoolMain
