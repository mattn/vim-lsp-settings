#!/bin/bash

set -e

cd $(dirname $0)

. ./pip3.sh
pip_install pyls python-language-server
