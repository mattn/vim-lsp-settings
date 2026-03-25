#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" herb-language-server @herb-tools/language-server
