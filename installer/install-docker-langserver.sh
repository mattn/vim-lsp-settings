#!/bin/bash

set -e

server_dir="../servers/docker-langserver"

cd $(dirname $0)
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

npm init -y
sed -i -e 's/\"name\":.*$/\"name\": \"\",/' package.json
npm install dockerfile-language-server-nodejs

ln -s ./node_modules/.bin/docker-langserver .
