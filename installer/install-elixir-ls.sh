#!/bin/sh

set -e

version="v0.15.1"
url="https://github.com/elixir-lsp/elixir-ls/releases/download/$version/elixir-ls-$version.zip"
curl -LO "$url"
unzip "elixir-ls-$version.zip"
rm "elixir-ls-$version.zip"

cat <<EOF >elixir-ls
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/language_server.sh \$*
EOF

chmod +x language_server.sh
chmod +x elixir-ls
