#!/usr/bin/env bash

set -e

python3 -m venv ./venv
./venv/bin/pip3 install -U pip
./venv/bin/pip3 install "esbonio[lsp]"
./venv/bin/pip3 install "pygls==0.9.1"

cat <<EOF >esbonio
#!/usr/bin/env bash

DIR=$(cd $(dirname $0); pwd)
$DIR/venv/bin/python3 -m esbonio
EOF

chmod +x esbonio
