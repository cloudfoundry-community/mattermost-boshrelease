#!/bin/bash

set -e -x

release_name=${release_name:-"postgresql-docker"}

if [[ -z "$(git config --global user.name)" ]]
then
  git config --global user.name "Concourse Bot"
  git config --global user.email "drnic+bot@starkandwayne.com"
fi
git clone boshrelease final-release
cd final-release

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

cat > config/private.yml << EOF
---
blobstore:
  s3:
    access_key_id: ${aws_access_key_id}
    secret_access_key: ${aws_secret_access_key}
EOF

bosh -n create release --final

version=$(ls releases/${release_name}/${release_name}-*yml | xargs -L1 basename | grep -o -E '[0-9]+' | sort -nr | head -n1)
git add -A
git commit -m "release v${version}"
