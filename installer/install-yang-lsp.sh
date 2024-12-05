#!/bin/sh

set -e

VERSION=0.7.6
curl -L -o yang-language-server.zip https://github.com/TypeFox/yang-lsp/releases/download/v$VERSION/yang-language-server_$VERSION.zip
unzip yang-language-server.zip
rm yang-language-server.zip
ln -sf yang-language-server-$VERSION/bin/yang-language-server yang-lsp
