#!/bin/sh

set -e

url="https://marketplace.visualstudio.com/_apis/public/gallery/publishers/dbaeumer/vsextensions/vscode-eslint/latest/vspackage"
asset="vscode-eslint.vsix"
curl --compressed -L "$url" -o "$asset"
unzip "$asset"
rm "$asset"

cat <<EOF >eslint-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/extension/server/out/eslintServer.js \$*
EOF

chmod +x eslint-language-server
