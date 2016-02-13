#!/bin/bash

set -e # fail fast

mattermost_dir=$(pwd)/mattermost
ls -al ${mattermost_dir}/

if [[ ! -f ${mattermost_dir}/mattermost.tar.gz ]]; then
  echo "Expected file ${mattermost_dir}/mattermost.tar.gz"
  exit 1
fi
mattermost_version=$(cat ${mattermost_dir}/version)
if [[ "${mattermost_version}X" == "X" ]]; then
  echo "Expected file ${mattermost_dir}/version"
  exit 1
fi

if [[ "${aws_access_key_id}X" == "X" ]]; then
  echo 'Require $aws_access_key_id, $aws_secret_access_key'
  exit 1
fi

if [[ -z "$(git config --global user.name)" ]]
then
  git config --global user.name "Concourse Bot"
  git config --global user.email "drnic+bot@starkandwayne.com"
fi
git clone boshrelease bumped-release
cd bumped-release

cat > config/private.yml << EOF
---
blobstore:
  s3:
    access_key_id: ${aws_access_key_id}
    secret_access_key: ${aws_secret_access_key}
EOF

mv ${mattermost_dir}/mattermost.tar.gz ${mattermost_dir}/mattermost-${mattermost_version}.tar.gz

# currently there are no other blobs than mattermost; so throw away old one.
cat > config/blob.yml << EOF
--- {}
EOF
bosh add blob ${mattermost_dir}/mattermost-${mattermost_version}.tar.gz mattermost
ls -alR blobs/

bosh -n upload blobs

git commit -a -m "updated mattermost v${mattermost_version}"
