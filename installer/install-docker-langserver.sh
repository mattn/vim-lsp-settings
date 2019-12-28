#!/bin/bash

set -e

cd $(dirname $0)

./npm_install.sh docker-langserver dockerfile-language-server-nodejs
