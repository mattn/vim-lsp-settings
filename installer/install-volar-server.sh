#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @volar/vue-language-server@0.34.11
mv vue-language-server volar-server
npm install typescript@4.6
