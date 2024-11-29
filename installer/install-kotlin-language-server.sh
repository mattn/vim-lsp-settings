#!/bin/sh

set -e

curl -L -o server.zip "https://github.com/fwcd/kotlin-language-server/releases/latest/download/server.zip"
unzip server.zip
rm server.zip

ln -s server/bin/kotlin-language-server .
