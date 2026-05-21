#!/bin/sh

set -e

version="v0.5.4"

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  if [ "$(uname -m)" = "x86_64" ]; then
    filename="helm_ls_linux_amd64"
  else
    filename="helm_ls_linux_arm"
  fi
  ;;
darwin)
  if [ "$(uname -m)" = "x86_64" ]; then
    filename="helm_ls_darwin_amd64"
  else
    filename="helm_ls_darwin_arm64"
  fi
  ;;
esac

curl -L -o helm-ls "https://github.com/mrjosh/helm-ls/releases/download/$version/$filename"
chmod 755 helm-ls
