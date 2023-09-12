#!/bin/sh

set -e

version="0.10.0"
url="https://github.com/tailwindlabs/tailwindcss-intellisense/releases/download/v$version/vscode-tailwindcss-$version.vsix"
asset="vscode-tailwindcss.vsix"

curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset" \[Content_Types\].xml extension.vsixmanifest

chmod +x extension/dist/tailwindServer.js

cat <<EOF >tailwindcss-intellisense
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/extension/dist/tailwindServer.js \$*
EOF

chmod +x tailwindcss-intellisense
