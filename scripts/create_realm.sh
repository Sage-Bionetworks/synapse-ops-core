#!/bin/bash
#
# Create a new Synapse realm
#
# Inputs to the script are the realm's name and a single identity provider (IdP) used by the realm.
# Note that the API is more general, allowing a list of IdPs to be passed in.  For simplicity here we
# just support the typical case of a single IdP.
#

set +x

NAME=${1}
IDENTITY_PROVIDER=${2}
SYNAPSE_HOST=${3}

echo NAME $NAME
echo IDENTITY_PROVIDER $IDENTITY_PROVIDER
echo SYNAPSE_HOST $SYNAPSE_HOST

# Retrieve a personal access token for a Synapse admin user from AWS secrets manager
ACCESS_TOKEN=`aws secretsmanager get-secret-value --secret-id /synapse/admin-pat --query SecretString --output text`

curl --fail-with-body --trace trace.log -X POST -H "Authorization:Bearer $ACCESS_TOKEN" -H content-type:application/json \
-d "{\"name\":\"$NAME\",\"identityProvider\":[{\"concreteType\":\"org.sagebionetworks.repo.model.auth.OAuthIdentityProvider\",\"provider\":\"$IDENTITY_PROVIDER\"}]}" $SYNAPSE_HOST/repo/v1/admin/realm

echo ----------- TRACE ---------------
cat trace.log
echo ---------- END TRACE ------------
