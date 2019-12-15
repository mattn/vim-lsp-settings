#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/vim-language-server ] && rm -rf ../servers/vim-language-server
mkdir ../servers/vim-language-server
cd ../servers/vim-language-server
git clone https://github.com/iamcco/vim-language-server .
yarn
yarn build

cat <<EOF > vim-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
node bin/index.js --stdio
EOF

chmod +x vim-language-server
