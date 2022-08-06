#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" elm-language-server "@elm-tooling/elm-language-server"
