#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" tsserver typescript
"$(dirname "$0")/npm_install.sh" vtsls @vtsls/language-server
