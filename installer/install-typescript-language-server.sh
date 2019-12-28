#!/bin/sh

set -e

cd $(dirname $0)

./npm_install.sh tsserver typescript
./npm_install.sh typescript-language-server typescript-language-server
