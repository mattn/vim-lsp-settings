#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" copilot-language-server @github/copilot-language-server
