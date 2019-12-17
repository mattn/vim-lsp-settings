#!/bin/bash

set -e

server_dir="../servers/pyls"

cd $(dirname $0)
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

python3 -m venv ./venv
./venv/bin/pip3 install python-language-server
ln -s ./venv/bin/pyls .
