#!/usr/bin/env bash

set -e

if [ ! -f package.json ]; then
  # Avoid the problem of not being able to install the same package as name in package.json.
  # Create an empty package.json.
  npm init -y
  echo '{"name": ""}' >package.json
fi

npm install "graphql"
npm install "graphql-language-service-cli"
ln -s "./node_modules/.bin/graphql-lsp" graphql-language-server
