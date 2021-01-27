#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
	platform="Linux"
	;;
darwin)
	platform="macOS"
	;;
esac

version="1.12.1"
url="https://github.com/sumneko/vscode-lua/releases/download/v$version/lua-$version.vsix"
asset="vscode-lua.vsix"

curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset"

chmod +x extension/server/bin/$platform/lua-language-server

cat <<EOF >sumneko-lua-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)/extension/server
\$DIR/bin/$platform/lua-language-server -E -e LANG=en \$DIR/main.lua \$*
EOF

chmod +x sumneko-lua-language-server
