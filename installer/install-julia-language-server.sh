#!/bin/sh

set -e

julia -e 'using Pkg; Pkg.add("LanguageServer")'

cat <<EOF >julia-language-server
#!/bin/sh

julia -e "using LanguageServer, LanguageServer.SymbolServer; runserver()"
EOF

chmod +x julia-language-server
