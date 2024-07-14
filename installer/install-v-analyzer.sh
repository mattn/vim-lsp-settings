#!/bin/sh

set -e

url="https://raw.githubusercontent.com/v-analyzer/v-analyzer/master/install.vsh"

# Replace hard-coded installation path "~/.config/v-analyzer" with "."
v -e "$(curl -fsSL "$url" | sed 's#~/.config/v-analyzer#.#g')"
mv bin/v-analyzer v-analyzer
