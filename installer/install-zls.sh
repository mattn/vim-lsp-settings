#!/bin/sh

set -e

git clone https://github.com/zigtools/zls .
git checkout "refs/tags/$(git tag --sort=-v:refname | grep "^$(zig version | sed -r 's/\.[0-9]+$//')" | head -n 1)"
git submodule update --init --recursive
zig build
mv zig-out/bin/zls .
rm -rf zig-cache .zig-cache zig-pkg zig-out src tests
cat <<EOF >zls.json
{"zig_lib_path":"$(dirname "$(which zig)")/lib/zig","enable_snippets":true,"warn_style":true,"enable_semantic_tokens":true}
EOF
