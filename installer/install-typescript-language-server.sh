#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/typescript-language-server ] && rm -rf ../servers/typescript-language-server
mkdir ../servers/typescript-language-server
cd ../servers/typescript-language-server
git clone https://github.com/theia-ide/typescript-language-server .
yarn
yarn build

cat <<EOF > typescript-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/server/lib/cli.js --stdio
EOF

chmod +x typescript-language-server
