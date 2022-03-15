#!/usr/bin/env bash

set -e

DEFAULT_DIR="$(pwd)"

# We should not download GitHub's zip file here, because it doesn't include some submodules.
git clone --recurse-submodules http://github.com/ocaml/ocaml-lsp.git ocaml-lsp-files --depth=1
cd ocaml-lsp-files

rm -r lsp/test
OPAMROOT="$(pwd)/.opam"
export OPAMROOT

export OPAMYES=true
opam init -a -n
opam switch create . ocaml-base-compiler.4.13.0
eval "$(opam env)" 2>/dev/null
opam exec make install-test-deps
opam exec make all

rm -rf .git

cd "$DEFAULT_DIR"
ln -snf "./ocaml-lsp-files/_build/default/ocaml-lsp-server/bin/main.exe" ocaml-lsp
chmod +x ocaml-lsp
