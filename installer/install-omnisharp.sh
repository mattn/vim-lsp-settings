#!/bin/bash

set -e

cd $(dirname $0)
[ -d ../servers/omnisharp ] && rm -rf ../servers/omnisharp
mkdir ../servers/omnisharp
cd ../servers/omnisharp
curl -L -o omnisharp-linux-x64.zip https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.34.9/omnisharp-linux-x64.zip
unzip omnisharp-linux-x64.zip
rm omnisharp-linux-x64.zip

cat <<EOF > omnisharp-run
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/run \$*
EOF

chmod +x omnisharp-run
