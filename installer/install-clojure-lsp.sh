#!/usr/bin/env bash

set -e

version="2021.02.01-20.37.52"
curl -L -o clojure-lsp "https://github.com/clojure-lsp/clojure-lsp/releases/download/$version/clojure-lsp"
chmod +x clojure-lsp
