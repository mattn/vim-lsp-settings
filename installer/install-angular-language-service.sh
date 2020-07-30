#!/usr/bin/env bash

set -e

"$(dirname "$0")/npm_install.sh" tsserver typescript
"$(dirname "$0")/npm_install.sh" angular-language-service @angular/language-service
