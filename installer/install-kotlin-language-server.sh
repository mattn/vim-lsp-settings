#!/bin/bash

set -e

curl -L -o server.zip 'https://github.com/fwcd/kotlin-language-server/releases/download/0.5.2/server.zip'
unzip server.zip
rm server.zip

ln -s server/bin/kotlin-language-server .
