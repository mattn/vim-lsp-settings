#!/bin/sh

set -e

if [ ! -f package.json ]; then
  # Avoid the problem of not being able to install the same package as name in package.json.
  # Create an empty package.json.
  npm init -y
  echo '{"name": ""}' >package.json
fi

npm install "@prisma/engines"
_DIR="$PWD"
cd "node_modules/@prisma/engines"
PRISMA_FMT_BASENAME="$(find . -name "prisma-fmt*")"
cd "$_DIR"

if [ ! -x "$PRISMA_FMT_BASENAME" ]; then
  ln -s "./node_modules/@prisma/engines/${PRISMA_FMT_BASENAME}" ./prisma-fmt
fi
"$(dirname "$0")/npm_install.sh" prisma-language-server @prisma/language-server
