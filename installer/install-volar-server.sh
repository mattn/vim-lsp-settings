#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @volar/vue-language-server@0.37.7
mv vue-language-server volar-server
npm install typescript@4.7
