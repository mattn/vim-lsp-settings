#!/bin/bash

set -e

cd $(dirname $0)

. ./npm.sh
npm_install yaml-language-server yaml-language-server
