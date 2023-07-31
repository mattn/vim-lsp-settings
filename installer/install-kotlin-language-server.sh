#!/bin/sh

set -e

version="1.3.3"
curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/download/$version/server.zip"
unzip server.zip
rm server.zip

ln -s server/bin/kotlin-language-server .
