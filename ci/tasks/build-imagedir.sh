#!/bin/bash

set -e -x

mkdir -p imagedir
cp -r boshrelease/ci/image/ imagedir/
cp -a cf-cli imagedir/

ls -al imagedir/
