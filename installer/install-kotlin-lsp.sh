#!/bin/sh

set -e

curl -L -o server.zip "https://download-cdn.jetbrains.com/kotlin-lsp/0.252.17811/kotlin-0.252.17811.zip"
unzip server.zip
rm server.zip
