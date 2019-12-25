#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install docker-langserver dockerfile-language-server-nodejs
