#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @volar/vue-language-server@~1.6.0
mv vue-language-server volar-server
npm install typescript@5.0.2
