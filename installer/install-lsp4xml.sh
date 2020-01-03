#!/bin/bash

set -e

version="0.9.1"
url=https://dl.bintray.com/lsp4xml/releases/org/lsp4xml/org.eclipse.lsp4xml/${version}/org.eclipse.lsp4xml-${version}-uber.jar

curl -LO "$url"

cat <<EOF >lsp4xml
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/org.eclipse.lsp4xml-${version}-uber.jar
EOF

chmod +x lsp4xml
