#!/bin/bash
#
# Resetting the status of a user to re-enable them.
#

set +x

USER_ID=${1}
SYNAPSE_HOST=${2}

# Retrieve a personal access token for a Synapse admin user from AWS secrets manager
ACCESS_TOKEN=`aws secretsmanager get-secret-value --secret-id /synapse/admin-pat --query SecretString --output text`

curl --fail-with-body -X PUT -H "Authorization:Bearer $ACCESS_TOKEN" -H content-type:application/json $SYNAPSE_HOST/repo/v1/admin/resetuserstatus/$USER_ID
