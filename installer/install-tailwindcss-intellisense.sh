#!/usr/bin/env bash

set -e

version="0.5.10"
url="https://github.com/tailwindlabs/tailwindcss-intellisense/releases/download/v$version/vscode-tailwindcss-$version.vsix"
asset="vscode-tailwindcss.vsix"

curl -L "$url" -o "$asset"
unzip "$asset"
rm "$asset" \[Content_Types\].xml extension.vsixmanifest


chmod +x extension/dist/server/index.js

cat <<EOF >tailwindcss-intellisense
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/extension/dist/server/index.js \$*
EOF

chmod +x tailwindcss-intellisense
