#!/usr/bin/env bash

set -e

"$(dirname "$0")/go_install.sh" golang.org/x/tools/gopls@latest
