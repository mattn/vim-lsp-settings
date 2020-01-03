#!/bin/bash

set -e

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
