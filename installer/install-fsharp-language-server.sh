#!/bin/bash

set -e

git clone https://github.com/fsprojects/fsharp-language-server .
npm install
dotnet build -c Release

cat <<EOF > fsharp-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll \$*
EOF

chmod +x fsharp-language-server
