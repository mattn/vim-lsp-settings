#!/bin/bash

# Usage
# $ npm_install [EXECUTABLE_NAME] [NPM_NAME]

set -e

npm init -y

# Avoid the problem of not being able to install the same package as name in package.json.
# Create an empty package.json.
cat <<EOF >package.json
{"name": ""}
EOF

npm install "$2"
ln -s "./node_modules/.bin/$1" .
