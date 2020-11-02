#!/usr/bin/env bash

set -e

nimble -y --nimbledir=$(pwd) install nimlsp
ln -s $(pwd)/bin/nimlsp .
