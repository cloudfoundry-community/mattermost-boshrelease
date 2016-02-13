#!/bin/bash

set -e -x

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

bosh -n create release --final --with-tarball

version=$(ls releases/*/*yml | xargs -L1 basename | grep -o -E '[0-9]+' | sort -nr | head -n1)
git add -A
git commit -m "release v${version}"

mattermost_version=$(cat config/blobs.yml | yaml2json | jq -r "keys | first | match(\"mattermost-(.*).tar.gz\") | .captures[0].string")

mkdir -p tmp/release
echo "v${version} - mattermost v${mattermost_version}" > tmp/release/name
echo "v${version}" > tmp/release/version
cat > tmp/release/notes.md << EOS
See https://github.com/mattermost/platform/releases/tag/v${mattermost_version} for Mattermost release notes.
EOS
