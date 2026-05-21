#!/bin/sh

set -e

version="22.1.6"

# On MacOS, use clangd in Command Line Tools for Xcode.
if command -v xcrun 2>/dev/null && xcrun --find clangd 2>/dev/null; then
  cat <<'EOF' >clangd
#!/bin/sh

exec xcrun --run clangd "$@"
EOF
  chmod +x clangd
  exit
fi

# Search for local clangd in PATH
if which "clangd" >/dev/null; then
  clangd --version
  exit 0
fi
for llvm_version in $(seq 30 -1 9); do
  cmd="clangd-$llvm_version"
  if which "$cmd" >/dev/null; then
    echo "Found $(which $cmd)"
    ln -sf "$(which "$cmd")" clangd
    ./clangd --version
    exit 0
  fi
done

# Otherwise download a prebuilt release from the LLVM project.
# Asset naming reference:
#   https://github.com/llvm/llvm-project/releases
os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m)
ext="tar.xz"

case $os in
linux)
  case $arch in
  x86_64)
    filename="LLVM-$version-Linux-X64"
    ;;
  aarch64 | arm64)
    filename="LLVM-$version-Linux-ARM64"
    ;;
  armv7l)
    filename="clang+llvm-$version-armv7a-linux-gnueabihf"
    ext="tar.gz"
    ;;
  *)
    echo "unsupported architecture: $arch"
    exit 1
    ;;
  esac
  ;;
darwin)
  case $arch in
  arm64 | aarch64)
    filename="LLVM-$version-macOS-ARM64"
    ;;
  *)
    echo "unsupported architecture: $arch"
    exit 1
    ;;
  esac
  ;;
*)
  echo "unsupported OS: $os"
  exit 1
  ;;
esac

url="https://github.com/llvm/llvm-project/releases/download/llvmorg-$version/$filename.$ext"
echo "Downloading clangd and LLVM $version..."
curl -L -o "clangd.$ext" "$url"
tar -xf "clangd.$ext" --strip-components=1 "$filename"
rm -f "clangd.$ext"
ln -sf bin/clangd .
./clangd --version
