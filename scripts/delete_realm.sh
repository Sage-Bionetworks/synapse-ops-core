#!/bin/bash
#
# Delete a Synapse realm
#

set +x

ID=${1}
SYNAPSE_HOST=${2}

# Retrieve a personal access token for a Synapse admin user from AWS secrets manager
ACCESS_TOKEN=`aws secretsmanager get-secret-value --secret-id /synapse/admin-pat --query SecretString --output text`

curl --fail-with-body -X DELETE -H "Authorization:Bearer $ACCESS_TOKEN" $SYNAPSE_HOST/repo/v1/admin/realm/$ID
