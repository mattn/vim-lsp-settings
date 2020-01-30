#!/usr/bin/env bash

set -e

git clone --depth=1 https://github.com/erlang-ls/erlang_ls .
make

ln -s ./_build/default/bin/erlang_ls erlang-ls
