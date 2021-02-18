#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" tsserver typescript
"$(dirname "$0")/npm_install.sh" angular-language-server @angular/language-server

cat <<EOF >angular-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/node_modules/@angular/language-server/index.js --ngProbeLocations \$DIR/node_modules/@angular/language-service --tsProbeLocations \$DIR/node_modules/typescript \$*
EOF

chmod +x angular-language-server
