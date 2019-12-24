#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install javascript-typescript-langserver javascript-typescript-langserver
