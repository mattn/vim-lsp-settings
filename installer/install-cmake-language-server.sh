#!/bin/sh

set -e

"$(dirname "$0")/pip_install.sh" cmake-language-server cmake-language-server
