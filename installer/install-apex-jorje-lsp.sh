#!/usr/bin/env bash

curl -o apex-jorje-lsp.jar "https://github.com/forcedotcom/salesforcedx-vscode/blob/develop/packages/salesforcedx-vscode-apex/out/apex-jorje-lsp.jar?raw=true"

cat <<EOF >apex-jorje-lsp

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/apex-jorje-lsp.jar %%* ^
EOF

chmod +x apex-jorje-lsp
