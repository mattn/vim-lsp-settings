#!/usr/bin/env bash

set -e

julia -e 'using Pkg; Pkg.add("LanguageServer")'

cat <<EOF >julia-language-server
#!/usr/bin/env bash

julia -e "using LanguageServer, LanguageServer.SymbolServer; runserver()"
EOF

chmod +x julia-language-server
