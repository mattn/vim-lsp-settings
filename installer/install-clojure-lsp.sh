#!/bin/bash

set -e

cd $(dirname $0)
[ -d ../servers/clojure-lsp ] && rm -rf ../servers/clojure-lsp
mkdir ../servers/clojure-lsp
cd ../servers/clojure-lsp
curl -L -o clojure-lsp https://github.com/snoe/clojure-lsp/releases/download/release-20191202T142318/clojure-lsp
chmod +x clojure-lsp
