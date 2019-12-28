#!/bin/bash

# Usage
# $ . npm.sh
# $ npm_install [EXECUTABLE_NAME] [NPM_NAME]

set -e

server_dir="../servers/$1"
[ -d "$server_dir" ] && rm -rf "$server_dir"
mkdir "$server_dir"
cd "$server_dir"

npm init -y

# Avoid the problem of not being able to install the same package as name in package.json.
# Create an empty package.json.
cat <<EOF >package.json
{"name": ""}
EOF

npm install "$2"
ln -s "./node_modules/.bin/$1" .
