#!/bin/bash

set -e

# REF https://github.com/neovim/nvim-lsp/blob/master/lua/nvim_lsp/pyls_ms.lua

server_dir="../servers/pyls_ms"

cd $(dirname $0)
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

curl -L https://dot.net/v1/dotnet-install.sh | bash -s -- -i "./.dotnet"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
case $os in
linux)
  system="linux"
  ;;
darwin)
  system="osx"
  ;;
*) ;;
esac

version="0.5.10"
url="https://pvsc.azureedge.net/python-language-server-stable/Python-Language-Server-${system}-x64.${version}.nupkg"

nupkg="./pyls.nupkg"
curl -L "$url" -o "$nupkg"
unzip "$nupkg"

cat <<EOF >pyls_ms
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/.dotnet/dotnet exec \$DIR/Microsoft.Python.LanguageServer.dll
EOF

chmod +x pyls_ms
