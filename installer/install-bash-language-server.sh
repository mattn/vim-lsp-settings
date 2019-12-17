#!/bin/bash

set -e

server_dir="../servers/bash-language-server"

cd $(dirname $0)
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

npm init -y
sed -i -e 's/\"name\":.*$/\"name\": \"\",/' package.json
npm install bash-language-server

ln -s ./node_modules/.bin/bash-language-server .
