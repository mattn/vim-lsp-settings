#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/javascript-typescript-langserver ] && rm -rf ../servers/javascript-typescript-langserver
mkdir ../servers/javascript-typescript-langserver
cd ../servers/javascript-typescript-langserver
git clone https://github.com/sourcegraph/javascript-typescript-langserver .
npm install
npm build

cat <<EOF > javascript-typescript-langserver
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/lib/language-server-stdio.js
EOF

chmod +x javascript-typescript-langserver
