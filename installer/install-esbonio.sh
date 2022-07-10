#!/bin/sh

set -e

python3 -m venv ./venv
./venv/bin/pip3 install -U pip
./venv/bin/pip3 install "esbonio[lsp]"

cat <<EOF >esbonio
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/venv/bin/python3 -m esbonio
EOF

chmod +x esbonio
