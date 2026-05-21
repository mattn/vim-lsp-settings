#!/bin/sh

set -e

version="v0.1.52"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m | tr "[:upper:]" "[:lower:]")

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
      tuple="x86_64-unknown-linux-musl"
    else
      tuple="x86_64-unknown-linux-gnu"
    fi
  else
    if [ "$kernel" = "musl" ]; then
      tuple="aarch64-unknown-linux-musl"
    else
      tuple="aarch64-unknown-linux-gnu"
    fi
  fi
  ;;
darwin)
  if [ "$arch" = "x86_64" ]; then
    tuple="x86_64-apple-darwin"
  else
    tuple="aarch64-apple-darwin"
  fi
  ;;
esac

filename="typos-lsp-$version-$tuple.tar.gz"

curl -L "https://github.com/tekumara/typos-lsp/releases/download/$version/$filename" | tar -xvz
