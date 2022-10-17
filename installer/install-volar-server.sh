#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @volar/vue-language-server@~1.0.0
mv vue-language-server volar-server
npm install typescript@4.8
