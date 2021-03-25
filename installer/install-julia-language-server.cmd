@echo off

julia -e "using Pkg; Pkg.add(PackageSpec(name=\"LanguageServer\", rev=\"master\"))"
julia -e "using Pkg; Pkg.add(PackageSpec(name=\"SymbolServer\", rev=\"master\"))"
julia -e "using Pkg; Pkg.add(PackageSpec(name=\"CSTParser\", rev=\"master\"))"

echo ^
using LanguageServer, LanguageServer.SymbolServer; runserver() ^

> languageserver.jl

echo @echo off ^

julia %%~dp0\languageserver.jl %%* ^

> julia-language-server.cmd
