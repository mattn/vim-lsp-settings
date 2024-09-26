#!/bin/sh

set -e

version="v0.23.0"
zip="elixir-ls-$version.zip"
url="https://github.com/elixir-lsp/elixir-ls/releases/download/$version/$zip"
curl -L -o "$zip" "$url"
unzip "$zip"
rm "$zip"

cat <<EOF >elixir-ls
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/language_server.sh \$*
EOF

chmod +x language_server.sh
chmod +x elixir-ls
