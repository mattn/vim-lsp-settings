#!/bin/bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
    linux)
        platform="pc-linux-gnu"
        ;;
    darwin)
        platform="darwin-apple"
        ;;
esac

distributor_id=$(lsb_release -a 2>&1 | grep 'Distributor ID' | awk '{print $3}')
case $distributor_id in
    # Check Ubuntu version
    Ubuntu)
        ubuntu_version=$(lsb_release -a 2>&1 | grep 'Release' | awk '{print $2}')
        case $ubuntu_version in
            14.04|16.04|18.04)
                platform="linux-gnu-ubuntu-$ubuntu_version"
                ;;
        esac
        ;;
    # Check LinuxMint version
    LinuxMint)
        linuxmint_version=$(lsb_release -a 2>&1 | grep 'Release' | awk '{print $2}')
        case $linuxmint_version in
            19|19.1|19.2|19.3)
                platform="linux-gnu-ubuntu-18.04"
                ;;
            18|18.1|18.2|18.3)
                platform="linux-gnu-ubuntu-16.04"
                ;;
        esac
        ;;
esac

filename="clang+llvm-9.0.0-x86_64-$platform"
url="http://releases.llvm.org/9.0.0/$filename.tar.xz"
echo "Downloading clangd and LLVM..."
curl -LO "$url"
echo "Extracting archive..."
tar xf $filename.tar.xz --strip-components=1 $filename/
rm $filename.tar.xz
ln -sf bin/clangd
./clangd --version
