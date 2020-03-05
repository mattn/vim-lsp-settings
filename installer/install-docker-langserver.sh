#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" docker-langserver dockerfile-language-server-nodejs
