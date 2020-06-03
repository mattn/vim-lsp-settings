#!/usr/bin/env bash

set -e

version="20191202T142318""
curl -L -o clojure-lsp https://github.com/snoe/clojure-lsp/releases/download/release-$version/clojure-lsp
chmod +x clojure-lsp
