#!/usr/bin/env bash

set -e

DEFAULT_DIR="$(pwd)"

# We should not download GitHub's zip file here, because it doesn't include some submodules.
git clone --recurse-submodules http://github.com/ocaml/ocaml-lsp.git ocaml-lsp-files  --depth=1
cd ocaml-lsp-files

rm -r lsp/test
export OPAMROOT="$(pwd)/.opam"
opam init -a -n
eval $(opam env)
opam switch create . -y
opam exec --switch=. dune build

rm -rf .git

cd "$DEFAULT_DIR"
ln -snf "./ocaml-lsp-files/_build/default/ocaml-lsp-server/src/main.exe" ocaml-lsp
chmod +x ocaml-lsp
