#!/bin/sh

set -e

"$(dirname "$0")/npm_install.sh" gql-language-server @playlyfe/gql-language-server
