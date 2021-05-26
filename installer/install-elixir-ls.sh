#!/usr/bin/env bash

set -e

version="v0.7.0"
url="https://github.com/elixir-lsp/elixir-ls/releases/download/$version/elixir-ls.zip"
curl -LO "$url"
unzip elixir-ls.zip
rm elixir-ls.zip

cat <<EOF >elixir-ls
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/language_server.sh \$*
EOF

chmod +x language_server.sh
chmod +x elixir-ls
