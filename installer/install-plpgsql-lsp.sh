#!/bin/sh

set -e

git clone --depth=1 https://github.com/UniqueVision/plpgsql-lsp .
npm install
npm run build

cat <<EOF >plpgsql-lsp
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/server/out/server.js \$*
EOF

chmod +x plpgsql-lsp
