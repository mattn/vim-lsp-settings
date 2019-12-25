#!/bin/sh

set -e

cd $(dirname $0)

. ./npm.sh
npm_install typescript-language-server typescript-language-server
