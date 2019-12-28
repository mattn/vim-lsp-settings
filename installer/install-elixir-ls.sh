#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/elixir-ls"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

version="v0.2.25"
url="https://github.com/JakeBecker/elixir-ls/releases/download/$version/elixir-ls.zip"
curl -LO "$url"
unzip elixir-ls.zip
rm elixir-ls.zip

cat <<EOF > elixir-ls
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/language_server.sh \$*
EOF

chmod +x elixir-ls
