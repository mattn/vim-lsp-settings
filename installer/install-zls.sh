#!/usr/bin/env bash

git clone --recurse-submodules --depth=1 https://github.com/zigtools/zls .
zig build
mv zig-cache/bin/zls .
rm -rf zig-cache src tests
cat <<EOF > zls.json
{"zig_lib_path":"$(dirname $(which zig))/lib/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true}
EOF
