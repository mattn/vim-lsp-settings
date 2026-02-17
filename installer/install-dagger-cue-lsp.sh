#!/bin/sh

set -e

# check if dagger is present
dagger_path=$(which dagger)
if [ -f $dagger_path ]; then
	echo "Dagger CLI already installed, using it…"
	exit 0
fi

os=$(uname -s | tr "[:upper:]" "[:lower:]")

url="http://can.not.find.cue.lsp.version"

arch=$(uname -i)
if [ "$arch" = "x86_64" ]; then
  arch="amd64"
elif [ "$arch" = "aarch64" ]; then
  arch="arm64"
fi

url=$(curl -H "Accept: application/vnd.github+json"   https://api.github.com/repos/dagger/cuelsp/releases/latest | grep $os | grep $arch | grep "browser_download_url" | awk '{ print $2; }' | sed 's/"//g' )

curl -L "$url" | tar -xz
