#!/bin/bash

set -e

cd $(dirname $0)
[ -d ../servers/omnisharp-node-client ] && rm -rf ../servers/omnisharp-node-client
mkdir ../servers/omnisharp-node-client
cd ../servers/omnisharp-node-client
git clone https://github.com/OmniSharp/omnisharp-node-client .
npm install
npm build

cat <<EOF > omnisharp-node-client
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/languageserver/server.js
EOF

chmod +x omnisharp-node-client
