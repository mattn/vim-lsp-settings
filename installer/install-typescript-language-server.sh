#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" tsserver typescript
"$(dirname "$0")/npm_install.sh" typescript-language-server typescript-language-server
