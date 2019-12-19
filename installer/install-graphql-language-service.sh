#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/graphql-language-service ] && rm -rf ../graphql-language-service
mkdir ../servers/graphql-language-service
cd ../servers/graphql-language-service
git clone https://github.com/graphql/graphql-language-service.git .
npm install
npm build

cat <<EOF > javascript-typescript-langserver
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node \$DIR/lib/language-server-stdio.js
EOF

chmod +x javascript-typescript-langserver
