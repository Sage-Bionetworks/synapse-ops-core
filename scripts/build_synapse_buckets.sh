#!/bin/bash
#
# Build Synapse Buckets
#

set +x

# dev, staging or prod
STACK=${1}

# Folder containing source code
SRC_PATH=${2}

cd $SRC_PATH

mvn clean install

# We fetch the latest version of the lambda artifact for the virus scanner using the artifactory API
VIRUS_SCANNER_REPO_API=https://sagebionetworks.jfrog.io/artifactory/api/storage/lambda-artifacts/org/sagebionetworks/virus-scanner/

VIRUS_SCANNER_LATEST_SPEC=$(curl -s "$VIRUS_SCANNER_REPO_API?lastModified" | tr -d "[:blank:]" | grep -oP '(?<="uri":")[^"]*')
VIRUS_SCANNER_LATEST_URL=$(curl -s "$VIRUS_SCANNER_LATEST_SPEC" | tr -d "[:blank:]" | grep -oP '(?<="downloadUri":")[^"]*')

export CMD_PROPS=\
" -Dorg.sagebionetworks.stack=${STACK}"\
" -Dorg.sagebionetworks.lambda.virusscanner.artifactUrl=$VIRUS_SCANNER_LATEST_URL"\

java -Xms256m -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar $CMD_PROPS org.sagebionetworks.template.s3.S3BuilderMain
