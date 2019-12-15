#!/bin/bash

set -e

cd $(dirname $0)
[ -d ../servers/kotlin-language-server ] && rm -rf ../servers/kotlin-language-server
mkdir ../servers/kotlin-language-server
cd ../servers/kotlin-language-server
curl -L -o server.zip 'https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip'
unzip server.zip
rm server.zip

ln -s server/bin/kotlin-language-server .
