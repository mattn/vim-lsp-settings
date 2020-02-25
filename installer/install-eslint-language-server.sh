#!/usr/bin/env bash

url="https://github.com/microsoft/vscode-eslint/releases/download/release%2F2.1.0-next.1/vscode-eslint-2.1.0.vsix"
asset="vscode-eslint.vsix"
curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset"

cat <<EOF >eslint-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/extension/server/out/eslintServer.js --stdio \$*
EOF

chmod +x eslint-language-server
