#!/bin/bash

set -e

version="0.9.1"
url="https://github.com/eclipse/che-che4z-lsp-for-cobol/releases/download/$version/cobol-language-support-$version.vsix"
curl -LO "$url"
unzip "cobol-language-support-$version.vsix"

cat <<EOF >./cobol-language-support
#!/bin/sh
DIR=\$(cd \$(dirname \$0); pwd)
java "-Dline.speparator=\r\n" -jar "\$DIR/extension/server/lsp-service-cobol-$version.jar" pipeEnabled
EOF

chmod +x ./cobol-language-support
