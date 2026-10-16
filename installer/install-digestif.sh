#!/bin/sh

set -e

# digestif requires Lua 5.3 or later, so prefer a luarocks for those versions
for luarocks in luarocks-5.4 luarocks-5.3 luarocks; do
  if command -v "$luarocks" >/dev/null 2>&1 && "$luarocks" install --tree "$(pwd)" digestif; then
    ln -sf ./bin/digestif digestif
    exit 0
  fi
done

echo "Need luarocks for Lua 5.3 or later to install digestif" >&2
exit 1
