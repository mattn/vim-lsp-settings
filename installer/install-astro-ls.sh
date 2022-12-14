#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" astro-ls @astrojs/language-server
