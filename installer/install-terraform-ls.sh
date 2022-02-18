#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch=$(uname -m | tr "[:upper:]" "[:lower:]")

case $os in
darwin | linux) ;;

*)
  printf "%s is not supported" "$os"
  exit 1
  ;;
esac

case $arch in
x86_64*) arch=amd64 ;;
386*) arch=386 ;;
arm64*) arch=arm64 ;;
*)
  printf "%s is not supported" "$arch"
  exit 1
  ;;
esac

version=$(
  curl --location --silent "https://api.github.com/repos/hashicorp/terraform-ls/releases/latest" |
    awk 'match($0, /"tag_name": "(.+)"/, a) { print a[1] }'
)
short_version=$(echo "${version}" | awk 'match($0, /v(.+)/, a) { print a[1] }')
filename="terraform-ls_${short_version}"
url="https://github.com/hashicorp/terraform-ls/releases/download/${version}/${filename}_${os}_${arch}.zip"
filename="${filename}.zip"

curl -L --progress-bar "$url" -o "$filename"

unzip "$filename"
rm "$filename"
