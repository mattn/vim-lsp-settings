@echo off

julia -e "using Pkg; Pkg.add(PackageSpec(name=\"LanguageServer\", rev=\"master\"))"
julia -e "using Pkg; Pkg.add(PackageSpec(name=\"SymbolServer\", rev=\"master\"))"
julia -e "using Pkg; Pkg.add(PackageSpec(name=\"CSTParser\", rev=\"master\"))"

echo ^
import LanguageServer ^

import Pkg ^

import SymbolServer ^

envpath = dirname(Pkg.Types.Context().env.project_file) ^

server = LanguageServer.LanguageServerInstance(stdin, stdout, false, envpath) ^

server.runlinter = true ^

run(server) ^

> languageserver.jl

echo @echo off ^

julia %%~dp0\languageserver.jl %%* ^

> julia-language-server.cmd
