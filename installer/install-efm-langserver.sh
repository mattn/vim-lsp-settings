#!/usr/bin/env bash

set -e

"$(dirname "$0")/go_install.sh" github.com/mattn/efm-langserver@latest
