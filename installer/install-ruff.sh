#!/bin/sh

set -e

"$(dirname "$0")/pip_install.sh" ruff ruff
