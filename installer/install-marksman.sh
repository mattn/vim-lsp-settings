#!/bin/sh

set -e

version="2026-02-08"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
if [ "$(uname -m)" = "x86_64" ];
then
  arch="x64"
else
  arch="arm64"
fi
case $os in
linux)
  platform="linux-"$arch
  ;;
darwin)
  platform="macos"
  ;;
esac

curl -L -o marksman "https://github.com/artempyanykh/marksman/releases/download/$version/marksman-$platform"
chmod +x marksman
