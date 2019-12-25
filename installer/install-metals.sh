#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/metals"

[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

curl -Lo ./coursier https://git.io/coursier-cli
chmod +x ./coursier

version="0.7.6"
java -jar ./coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:$version" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o ./metals
