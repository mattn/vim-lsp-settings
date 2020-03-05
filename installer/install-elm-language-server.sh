#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" elm-languageserver "@elm-tooling/elm-language-server"
