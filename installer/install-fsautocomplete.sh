#!/bin/bash

set -e

if command -v dotnet >/dev/null 2>&1; then
  echo "dotnet installed"
  dotnetcmd=dotnet
else
  echo "dotnet not found, installing..."
  # REF https://github.com/neovim/nvim-lsp/blob/master/lua/nvim_lsp/pyls_ms.lua
  curl -L https://dot.net/v1/dotnet-install.sh | bash -s -- -i "./.dotnet"
  dotnetcmd="\\$DIR/.dotnet/dotnet"
fi

$dotnetcmd tool install --tool-path . fsautocomplete
