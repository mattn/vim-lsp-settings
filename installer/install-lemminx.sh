#!/usr/bin/env bash

set -e

# Latest version is available on https://repo.eclipse.org/content/repositories/lemminx-snapshots/org/eclipse/org.eclipse.lemminx/.
# But the lemminx snapshot jar on repo.eclipse.org seems to be obsolete when a new version is released.
# To avoid confusion, this script refers to lemminx bundled with vscode-xml.

vscode_xml_version="0.11.0"
lemminx_version="0.11.1"
url="https://github.com/redhat-developer/vscode-xml/releases/download/${vscode_xml_version}/redhat.vscode-xml-${vscode_xml_version}.vsix"
extention="redhat.vscode-xml-${vscode_xml_version}.vsix"
lemminx_jar="org.eclipse.lemminx-${lemminx_version}-uber.jar"

curl -L "$url" -o "$extention"
unzip -d vscode-xml "$extention"
rm "$extention"
ln -s "vscode-xml/extension/server/${lemminx_jar}" .

cat <<EOF >lemminx
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/${lemminx_jar}
EOF

chmod +x lemminx
