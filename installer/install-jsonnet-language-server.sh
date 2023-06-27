#!/bin/sh

set -e

"$(dirname "$0")/go_install.sh" github.com/grafana/jsonnet-language-server@latest
