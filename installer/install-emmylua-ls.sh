#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/emmylua-ls ] && rm -rf ../servers/emmylua-ls
mkdir ../servers/emmylua-ls
cd ../servers/emmylua-ls
curl -L -o EmmyLua-LS-all.jar 'https://ci.appveyor.com/api/buildjobs/54yf9rjvj49494pd/artifacts/EmmyLua-LS%2Fbuild%2Flibs%2FEmmyLua-LS-all.jar'

cat <<EOF > emmylua-ls
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -cp \$DIR/EmmyLua-LS-all.jar com.tang.vscode.MainKt
EOF

chmod +x emmylua-ls
