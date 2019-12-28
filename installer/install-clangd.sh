#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/clangd"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
    linux)
        platform="pc-linux-gnu"
        ;;
    darwin)
        platform="darwin-apple"
        ;;
esac

# Check Ubuntu version
ubuntu_version=$(lsb_release -a 2>&1 | grep 'Release' | awk '{print $2}')

case $ubuntu_version in
    14.04|16.04|18.04)
        platform="linux-gnu-ubuntu-$ubuntu_version"
        ;;
esac

filename="clang+llvm-9.0.0-x86_64-$platform"
url="http://releases.llvm.org/9.0.0/$filename.tar.xz"
echo "Downloading clangd and LLVM..."
curl -LO "$url"
echo "Extracting archive..."
tar xvf $filename.tar.xz --strip-components=1 $filename/
rm $filename.tar.xz
ln -sf bin/clangd
./clangd --version
