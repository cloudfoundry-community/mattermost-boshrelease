#!/bin/bash

set -e # fail fast

cf login -a https://api.run.pivotal.io -u ${cf_username} -p ${cf_password} -o ${cf_org} -s ${cf_space}

set -x # print commands

service_keys=$(cf curl $(cf curl "/v2/spaces/$(cat ~/.cf/config.json| jq -r .SpaceFields.Guid)/service_instances?q=name:${cf_service_name}" | jq -r ".resources[0].entity.service_keys_url") | jq -r ".resources[].metadata.url")
for key in $service_keys; do
  cf curl -X DELETE ${key}
done

cf ds -f ${cf_service_name}
cf cs elephantsql turtle ${cf_service_name}
cf create-service-key ${cf_service_name} ${cf_service_name}-key

service_key_info=$(cf curl "/v2/spaces/$(cat ~/.cf/config.json| jq -r .SpaceFields.Guid)/service_instances?q=name:${cf_service_name}" | jq -r ".resources[0].entity.service_keys_url")
db_uri=$(cf curl ${service_key_info} | jq -r ".resources[0].entity.credentials.uri")
db_max_conns=$(cf curl ${service_key_info} | jq -r ".resources[0].entity.credentials.max_conns")

cat > tmp/testconfig.yml << EOF
jobs:
  - name: mattermost
    properties:
      mattermost:
        sql:
          driver_name: postgres
          max_connections: ${db_max_conns}
          url: ${db_uri}
EOF

echo tmp/testconfig.yml
