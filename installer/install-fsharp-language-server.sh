#!/bin/sh

set -e

git clone --depth=1 https://github.com/fsprojects/fsharp-language-server .
npm install
dotnet build -c Release

cat <<EOF >fsharp-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/FSharpLanguageServer.dll \$*
EOF

chmod +x fsharp-language-server
