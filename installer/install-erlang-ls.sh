#!/bin/sh

set -e

git clone --depth=1 https://github.com/erlang-ls/erlang_ls .
make

# escript uses the script name as the module name, so a symlink named
# erlang-ls does not work. Use a wrapper script instead.
cat <<'EOF2' >erlang-ls
#!/bin/sh
DIR=$(cd "$(dirname "$0")" && pwd)
exec "$DIR/_build/default/bin/erlang_ls" "$@"
EOF2
chmod +x erlang-ls
