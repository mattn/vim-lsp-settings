#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
if [ $(uname -m) = "x86_64" ];
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

curl -L -o marksman "https://github.com/artempyanykh/marksman/releases/latest/download/marksman-$platform"
chmod +x marksman
