#!/usr/bin/env bash

set -e

git clone --depth=1 https://github.com/sveltejs/language-tools .

(cd packages/language-server && npm install && npm run build)

cat <<EOF >svelte-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/packages/language-server/bin/server.js \$*
EOF

chmod +x svelte-language-server
