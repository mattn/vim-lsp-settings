#!/usr/bin/env bash

git clone "https://github.com/microsoft/vscode-eslint" .
git checkout release/1.9.1
npm install
npm run compile:server

cat <<EOF >eslint-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/server/out/eslintServer.js --stdio \$*
EOF

chmod +x eslint-language-server
