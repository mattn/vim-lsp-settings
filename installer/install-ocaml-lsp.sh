#!/usr/bin/env bash

set -e

DEFAULT_DIR="$(pwd)"

# We should not download GitHub's zip file here, because it doesn't include some submodules.
git clone --recurse-submodules http://github.com/ocaml/ocaml-lsp.git ocaml-lsp-files --depth=1
cd ocaml-lsp-files

rm -r lsp/test
OPAMROOT="$(pwd)/.opam"
export OPAMROOT

opam init -a -n
eval "$(opam env)" 2> /dev/null
opam switch create . --with-test -y
opam exec --switch=. dune build

rm -rf .git

cd "$DEFAULT_DIR"
ln -snf "./ocaml-lsp-files/_build/default/ocaml-lsp-server/src/main.exe" ocaml-lsp
chmod +x ocaml-lsp
