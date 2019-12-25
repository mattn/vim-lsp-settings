#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install elm-languageserver "@elm-tooling/elm-language-server"
