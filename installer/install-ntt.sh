#!/bin/bash

set -e
set -o pipefail

os="$(uname -s | tr "[:upper:]" "[:lower:]")"

case "${os}" in
darwin|linux)
  url="https://github.com/nokia/ntt/releases/latest/download/ntt_${os}_x86_64.tar.gz"
  curl -L "$url" | tar xz ntt
  chmod +x ntt
  ;;

*)
  echo >&2 "$os is not supported"
  exit 1
  ;;

esac
