#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/lsp4xml"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

version="0.9.1"
url=https://dl.bintray.com/lsp4xml/releases/org/lsp4xml/org.eclipse.lsp4xml/${version}/org.eclipse.lsp4xml-${version}-uber.jar

curl -LO "$url"

cat <<EOF >lsp4xml
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/org.eclipse.lsp4xml-${version}-uber.jar
EOF

chmod +x lsp4xml
