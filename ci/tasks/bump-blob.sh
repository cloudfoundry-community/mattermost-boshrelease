#!/bin/bash

set -e # fail fast

if [[ "${aws_access_key_id}X" == "X" ]]; then
  echo 'Require $aws_access_key_id, $aws_secret_access_key'
  exit 1
fi

cat > config/private.yml << EOF
---
blobstore:
  s3:
    access_key_id: ${aws_access_key_id}
    secret_access_key: ${aws_secret_access_key}
EOF

sudo apt-get update -y
sudo apt-get install tree -y
tree .

if [[ ! -f tmp/mattermost/mattermost.tar.gz ]]; then
  echo "Expected file tmp/mattermost/mattermost.tar.gz"
  exit 1
fi

version=$(cat tmp/mattermost/version)
cp tmp/mattermost/mattermost.tar.gz tmp/mattermost-${version}.tar.gz
bosh add blob tmp/mattermost-${version}.tar.gz mattermost

bosh -n upload blobs

if [[ -z "$(git config --global user.name)" ]]
then
  git config --global user.name "Concourse Bot"
  git config --global user.email "drnic+bot@starkandwayne.com"
fi

git commit -a -m "updated mattermost v${version}"
