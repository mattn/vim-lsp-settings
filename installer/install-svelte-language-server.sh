#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" svelteserver svelte-language-server
mv svelteserver svelte-language-server
