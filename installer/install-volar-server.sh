#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" volar-server @volar/server@0.27.25
npm install typescript@4.4
