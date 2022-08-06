#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" javascript-typescript-stdio javascript-typescript-langserver
