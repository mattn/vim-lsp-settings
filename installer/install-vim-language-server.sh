#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install vim-language-server vim-language-server
