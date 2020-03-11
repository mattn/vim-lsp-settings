#!/usr/bin/env bash

set -e

"$(dirname "$0")/go_install.sh" github.com/nametake/golangci-lint-langserver@latest
"$(dirname "$0")/go_install.sh" github.com/golangci/golangci-lint/cmd/golangci-lint@latest
