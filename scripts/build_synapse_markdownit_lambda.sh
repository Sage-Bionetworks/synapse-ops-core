#!/bin/bash
#
# Build and run
#

set +x

# dev, staging or prod
STACK=${1}

# For instance 440 for Beanstalk number 12, string would be '440-12'
RELEASE_VERSION=${2}

# Folder containing source code
SRC_PATH=${3}

cd $SRC_PATH

mvn clean install

CMD_PROPS=" -Dorg.sagebionetworks.stack=${STACK}"
CMD_PROPS+=" -Dorg.sagebionetworks.lambda.markdownit.release.version=${RELEASE_VERSION}"
export ${CMD_PROPS}

echo ${CMD_PROPS}

echo java $CMD_PROPS -Xms256m -Xmx2g -cp ./target/stack-builder-0.2.0-SNAPSHOT-jar-with-dependencies.jar org.sagebionetworks.template.markdownit.MarkdownItLambdaBuilderMain
