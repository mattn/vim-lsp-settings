#!/usr/bin/env bash

set -e

# REF https://github.com/neovim/nvim-lsp/blob/master/lua/nvim_lsp/pyls_ms.lua

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

version="0.5.59"
url="https://pvsc.azureedge.net/python-language-server-stable/Python-Language-Server-${system}-x64.${version}.nupkg"

nupkg="./pyls.nupkg"
curl -L "$url" -o "$nupkg"
unzip "$nupkg"

cat <<EOF >pyls-ms
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/.dotnet/dotnet \$DIR/Microsoft.Python.LanguageServer.dll
EOF

chmod +x pyls-ms
