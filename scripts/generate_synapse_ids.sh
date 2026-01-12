#!/bin/bash
#
# Generate Synapse IDs to a SQL script to initialize a new idGenerator database
#

SYNAPSE_HOST=${1}

set +x
# Retrieve a personal access token for a Synapse admin user from AWS secrets manager
ACCESS_TOKEN=`aws secretsmanager get-secret-value --secret-id /synapse/admin-pat --query SecretString --output text`

echo $SYNAPSE_HOST/repo/v1/admin/id/generator/export
curl --fail-with-body -H "Authorization:Bearer $ACCESS_TOKEN" $SYNAPSE_HOST/repo/v1/admin/id/generator/export
