#!/bin/sh

set -e

DEFAULT_DIR="$(pwd)"

mkdir -p ocaml-lsp-files
cd ocaml-lsp-files

OPAMROOT="$(pwd)/.opam"
export OPAMROOT

export OPAMYES=true
opam init -a -n
opam switch create . ocaml-base-compiler.4.14.1
eval "$(opam env)" 2>/dev/null
opam install ocaml-lsp-server

cd "$DEFAULT_DIR"
ln -snf "./ocaml-lsp-files/_opam/bin/ocamllsp" ocaml-lsp
chmod +x ocaml-lsp
