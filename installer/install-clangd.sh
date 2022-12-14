#!/bin/sh

set -e

# On MacOS, use clangd in Command Line Tools for Xcode.
if command -v xcrun 2>/dev/null && xcrun --find clangd 2>/dev/null; then
  cat <<'EOF' >clangd
#!/bin/sh

exec xcrun --run clangd "$@"
EOF
  chmod +x clangd
  exit
fi

if command -v lsb_release 2>/dev/null; then
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
  distributor_id="Unknown"
fi

filename() {
  distributor_id=$1
  version=$2

  os=$(uname -s | tr "[:upper:]" "[:lower:]")

  case $os in
  linux)
    platform="pc-linux-gnu"
    ;;
  darwin)
    platform="apple-darwin"
    ;;
  esac

  case $distributor_id in
  # Check Ubuntu version
  Ubuntu)
    ubuntu_version=$(lsb_release -a 2>&1 | grep 'Release' | awk '{print $2}')
    case $ubuntu_version in
    14.04 | 16.04 | 18.04 | 20.04)
      platform="linux-gnu-ubuntu-$ubuntu_version"
      ;;
    22.04)
      local platform="linux-gnu-ubuntu-20.04"
    esac
    ;;
  # Check LinuxMint version
  LinuxMint)
    linuxmint_version=$(lsb_release -a 2>&1 | grep 'Release' | awk '{print $2}')
    case $linuxmint_version in
    19 | 19.1 | 19.2 | 19.3)
      platform="linux-gnu-ubuntu-18.04"
      ;;
    18 | 18.1 | 18.2 | 18.3)
      platform="linux-gnu-ubuntu-16.04"
      ;;
    esac
    ;;
  # Check RedHat OS version
  Fedora | Oracle | CentOS)
    case $version in
    9.0.0 | 10.0.0)
      platform="linux-sles11.3"
      ;;
    11.0.0)
      platform="linux-sles12.4"
      ;;
    esac
    ;;
  esac

  # Check Architecture
  arch=$(uname -m)
  case $arch in
  aarch64)
    platform="linux-gnu"
    ;;
  esac

  echo "clang+llvm-$version-$arch-$platform"
}


# Search for an installable clang+llvm release.
for llvm_version in 15 14 13 12 11 10 9; do
  filename="$(filename "$distributor_id" "$llvm_version.0.0")"
  url="https://github.com/llvm/llvm-project/releases/download/llvmorg-$llvm_version.0.0/$filename.tar.xz"
  response_code=$(curl -sIL "${url}" -o /dev/null -w "%{response_code}")

  # If version exists, install it and exit.
  if [ "${response_code}" -ne "404" ]; then
    echo "Downloading clangd and LLVM $llvm_version..."
    curl -L "$url" | unxz | tar x --strip-components=1 "$filename"/
    ln -sf bin/clangd .
    ./clangd --version
    exit 0
  fi
done

echo "Could not find an installable clangd release!"
exit 1
