#!/usr/bin/env bash

set -e

DEFAULT_DIR="$(pwd)"
INSTALL_DIR="$DEFAULT_DIR/bin"


# We should not download GitHub's zip file here, because it doesn't include some submodules.
git clone --recurse-submodules http://github.com/ocaml/ocaml-lsp.git --depth=1
cd ocaml-lsp

rm -r lsp/test
export OPAMROOT="$(pwd)/.opam"
opam init -a -n
eval $(opam env)
opam switch create . -y
opam exec --switch=. dune build

rm -rf .git

cd "$DEFAULT_DIR"
ln -snf "ocaml-lsp/_build/install/default/bin/ocamllsp" .
chmod +x ocamllsp

# output : ./ocamllsp

