#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @volar/vue-language-server@0.33.6
npm install typescript@4.6
