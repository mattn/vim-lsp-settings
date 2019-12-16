#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/rls ] && rm -rf ../servers/rls
mkdir ../servers/rls
cd ../servers/rls
CARGO_HOME=$(pwd) cargo install rls 
cp bin/rls .
rm -rf bin registry .package-cache .crates.toml
