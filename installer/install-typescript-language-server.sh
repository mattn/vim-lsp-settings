#!/bin/sh

set -e

cd $(dirname $0)

. ./npm.sh

pushd . > /dev/null
npm_install tsserver typescript
popd > /dev/null

pushd . > /dev/null
npm_install typescript-language-server typescript-language-server
popd > /dev/null
