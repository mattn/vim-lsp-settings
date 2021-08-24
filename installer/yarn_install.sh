#!/usr/bin/env bash

# Usage
# $ yarn_install [EXECUTABLE_NAME] [NPM_NAME]

set -e

# Supporting multiple yarn packages(e.g. typescript-language-server uses typescript-language-server and tsserver).
# If package.json exists, skip calling yarn init.
if [ ! -f package.json ]; then
  # Avoid the problem of not being able to install the same package as name in package.json.
  # Create an empty package.json.
  yarn init -y
  echo '{"name": ""}' >package.json
fi

yarn add "$2"
ln -s "./node_modules/.bin/$1" .
