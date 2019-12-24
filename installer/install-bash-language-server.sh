#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install bash-language-server bash-language-server
