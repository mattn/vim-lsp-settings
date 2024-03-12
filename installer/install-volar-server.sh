#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" vue-language-server @vue/language-server@~2.0.0
mv vue-language-server volar-server
npm install typescript@5.4.2
