#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  platform="linux"
  ;;
darwin)
  platform="mac"
  ;;
esac

if [ ! which grep &> /dev/null ] || [ ! which cut &> /dev/null ]; then
  version="2021-02-15"
else
  version=$(curl -sL https://api.github.com/repos/rust-analyzer/rust-analyzer/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
fi

curl -L -o rust-analyzer-$platform "https://github.com/rust-analyzer/rust-analyzer/releases/download/$version/rust-analyzer-$platform"

mv rust-analyzer-$platform rust-analyzer
chmod +x rust-analyzer
