#!/usr/bin/env bash

raco pkg install racket-langserver
cat <<EOF >racket-lsp
#!/bin/sh

racket -l racket-langserver 
EOF

chmod +x racket-lsp
