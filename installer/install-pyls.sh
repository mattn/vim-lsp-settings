#!/bin/bash

set -e

cd $(dirname $0)

./pip_install.sh pyls python-language-server
