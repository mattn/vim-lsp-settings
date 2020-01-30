#!/usr/bin/env bash

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

if which lsb_release 2> /dev/null; then
    distributor_id=$(lsb_release -a 2>&1 | grep 'Distributor ID' | awk '{print $3}')
elif [ -e /etc/fedora-release ]; then
    distributor_id="Fedora"
elif [ -e /etc/redhat-release ]; then
    distributor_id=$(cat /etc/redhat-release | cut -d ' ' -f 1)
elif [ -e /etc/arch-release ]; then
    distributor_id="Arch"
elif [ -e /etc/SuSE-release ]; then
    distributor_id="SUSE"
elif [ -e /etc/mandriva-release ]; then
    distributor_id="Mandriva"
elif [ -e /etc/vine-release ]; then
    distributor_id="Vine"
elif [ -e /etc/gentoo-release ]; then
    distributor_id="Gentoo"
else
    distributor_id="Unkown"
fi

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
    # Check RedHat OS version
    Fedora|Oracle|CentOS)
        platform="linux-sles11.3"
        ;;
esac

filename="clang+llvm-9.0.0-x86_64-$platform"
url="http://releases.llvm.org/9.0.0/$filename.tar.xz"
echo "Downloading clangd and LLVM..."
curl -LO "$url"
echo "Extracting archive..."
xzcat $filename.tar.xz | tar x --strip-components=1 $filename/
rm $filename.tar.xz
ln -sf bin/clangd
./clangd --version
