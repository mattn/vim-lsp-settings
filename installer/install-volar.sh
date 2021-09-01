#!/usr/bin/env bash

set -e

if [ ! -f package.json ]; then
  # Avoid the problem of not being able to install the same package as name in package.json.
  # Create an empty package.json.
  npm init -y
  echo '{"name": ""}' >package.json
fi

npm install @volar/server@0.27.12-alpha.1
npm install typescript@4.3 # volar doesn't work well with TS4.4

cat <<EOF >volar
#!/usr/bin/env node

require('./node_modules/@volar/server/out/index.js')
EOF

chmod +x volar

