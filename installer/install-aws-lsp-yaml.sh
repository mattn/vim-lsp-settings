#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" yaml-language-server @aws/lsp-yaml
ln -s yaml-language-server aws-lsp-yaml
