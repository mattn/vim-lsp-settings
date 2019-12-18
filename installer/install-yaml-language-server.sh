#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/yaml-language-server"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

npm init -y
cat <<EOF >package.json
{"name": ""}
EOF
npm install yaml-language-server

ln -s ./node_modules/.bin/yaml-language-server .
