#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="$(uname -m)"
ext="tar.gz"

case $os in
linux)
  case $(uname -r) in
    *-musl)
      kernel=musl
      ;;
    *)
      kernel=glibc
      ;;
  esac
  if [ "$arch" = "x86_64" ]; then
    if [ "$kernel" = "musl" ]; then
      platform="linux-x64-musl"
    else
      platform="linux-x64"
    fi
  else
    if [ "$kernel" = "musl" ]; then
      platform="linux-arm64-musl"
    else
      platform="linux-arm64"
    fi
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    platform="darwin-x64"
  else
    platform="darwin-arm64"
  fi
  ;;
esac

curl -L -o "oxfmt.$ext" "https://github.com/oxc-project/oxc/releases/latest/download/oxfmt-$platform.$ext"
if [ "$ext" = "zip" ]; then
  unzip "oxfmt.zip"
else
  tar -xf "oxfmt.tar.gz"
fi

mv oxfmt-$platform oxfmt
chmod +x oxfmt
rm "oxfmt.$ext"
