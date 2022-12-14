#!/bin/sh

set -e

"$(dirname "$0")/go_install.sh" github.com/bufbuild/buf-language-server/cmd/bufls@latest
