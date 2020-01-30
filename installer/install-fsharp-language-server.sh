#!/usr/bin/env bash

set -e

git clone https://github.com/fsprojects/fsharp-language-server .
npm install
dotnet build -c Release

cat <<EOF > fsharp-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll \$*
EOF

chmod +x fsharp-language-server
