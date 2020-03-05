#!/usr/bin/env bash

set -e

julia -e 'using Pkg; Pkg.add(PackageSpec(name="LanguageServer", rev="master"))'
julia -e 'using Pkg; Pkg.add(PackageSpec(name="SymbolServer", rev="master"))'
julia -e 'using Pkg; Pkg.add(PackageSpec(name="CSTParser", rev="master"))'

cat <<EOF >languageserver.jl
import LanguageServer
import Pkg
import SymbolServer
envpath = dirname(Pkg.Types.Context().env.project_file)
server = LanguageServer.LanguageServerInstance(stdin, stdout, false, envpath)
server.runlinter = true
run(server)
EOF

cat <<EOF >julia-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
julia \$DIR/languageserver.jl \$*
EOF

chmod +x julia-language-server
