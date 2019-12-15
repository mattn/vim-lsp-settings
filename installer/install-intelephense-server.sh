#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/intelephense-server ] && rm -rf ../servers/intelephense-server
mkdir ../servers/intelephense-server
cd ../servers/intelephense-server
git clone "https://github.com/bmewburn/vscode-intelephense" .
npm install
npm run compile

cat <<EOF > intelephense-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/node_modules/.bin/intelephense --stdio
EOF

chmod +x intelephense-server
