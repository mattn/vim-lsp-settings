#!/usr/bin/env bash

set -e

version="2.1.0"
url="https://github.com/microsoft/vscode-eslint/releases/download/release%2F$version-next.1/vscode-eslint-$version.vsix"
asset="vscode-eslint.vsix"
curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset"

cat <<EOF >eslint-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/extension/server/out/eslintServer.js \$*
EOF

chmod +x eslint-language-server
