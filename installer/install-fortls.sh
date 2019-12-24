#!/bin/bash

cd $(dirname $0)

. ./pip3.sh
pip_install fortls fortran-language-server
