#!/bin/sh

set -e
os=$(uname -s | tr "[:upper:]" "[:lower:]")
url="${url_ubuntu}"
platform="ubuntu"
version="0.2"

case $os in
linux)
  platform="ubuntu"
  ;;
darwin)
  platform="macos"
  ;;
*)
  echo "unknow platform: $os"
  exit 1
  ;;
esac

curl -L -o "qmlls-${platform}.zip" "https://github.com/TheQtCompanyRnD/qmlls-workflow/releases/download/${version}/qmlls-${platform}-${version}.zip"

tar -xf "qmlls-${platform}.zip" qmlls
rm "qmlls-${platform}.zip"
chmod +x qmlls

