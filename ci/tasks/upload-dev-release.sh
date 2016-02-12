#!/bin/bash

set -e
set -x

sql_service=$(pwd)/sql-service
cd boshrelease

if [[ "${bosh_target}X" == "X" ]]; then
  echo 'Require $bosh_target, $bosh_username, $bosh_password'
  exit 1
fi

cat > ~/.bosh_config << EOF
---
aliases:
  target:
    bosh-lite: ${bosh_target}
auth:
  ${bosh_target}:
    username: ${bosh_username}
    password: ${bosh_password}
EOF

bosh target ${bosh_target}

bosh create release --name mattermost
bosh -n upload release --rebase

./templates/make_manifest warden ${sql_service}/sql_service_bosh_config.yml

bosh -n delete deployment mattermost-warden || "skipping failed delete"
bosh -n deploy
