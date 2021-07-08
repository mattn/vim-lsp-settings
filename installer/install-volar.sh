#!/usr/bin/env bash

set -e

if [ ! -f package.json ]; then
  # Avoid the problem of not being able to install the same package as name in package.json.
  # Create an empty package.json.
  npm init -y
  echo '{"name": ""}' >package.json
fi

npm install "vscode-vue-languageservice"

cat <<EOF >volar
#!/usr/bin/env node

require('./node_modules/vscode-vue-languageservice/out/index.js')
EOF

chmod +x volar

