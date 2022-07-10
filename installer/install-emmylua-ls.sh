#!/bin/sh

set -e

version="0.3.6"
curl -L -o EmmyLua-LS-all.jar "https://github.com/EmmyLua/EmmyLua-LanguageServer/releases/download/$version/EmmyLua-LS-all.jar"

cat <<EOF >emmylua-ls
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -cp \$DIR/EmmyLua-LS-all.jar com.tang.vscode.MainKt
EOF

chmod +x emmylua-ls
