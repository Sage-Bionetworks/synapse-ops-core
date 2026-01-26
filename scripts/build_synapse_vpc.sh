#!/bin/bash
#
# Build Synapse Account VPC
#

set +x

# dev orprod
STACK=${1}
# vpn CIDR
VPN_CIDR=${2}
# vpn new CIDR
VPN_CIDR_NEW=${3}
# availibility zones
AVAILABILITY_ZONES=${4}
# subnet prefix
SUBNET_PREFIX=${5}
# colors csv
COLORS_CSV=${6}
# endpoints color
ENDPOINTS_COLOR=${7}
# endpoints availability zones
ENDPOINTS_AVAILABILITY_ZONES=${8}
# peering accept role
PEERING_ACCEPT_ROLE=${9}

# Folder containing source code
SRC_PATH=${10}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.vpn.cidr=${VPN_CIDR}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.vpn.cidr.new=${VPN_CIDR_NEW}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.availability.zones=${AVAILABILITY_ZONES}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.subnet.prefix=${SUBNET_PREFIX}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.colors.csv=${COLORS_CSV}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.endpoints.color=${ENDPOINTS_COLOR}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.endpoints.availability.zones=${ENDPOINTS_AVAILABILITY_ZONES}"
CMD_PROPS+=" -Dorg.sagebionetworks.vpc.peering.accept.role=${PEERING_ACCEPT_ROLE}"
export $CMD_PROPS

java $CMD_PROPS -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.vpc.VpcBuilderMain
