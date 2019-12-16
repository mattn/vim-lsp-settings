@echo off

setlocal

cd %~dp0
if exist "..\servers\rls" rd /S /Q  "..\servers\rls"
md "..\servers\rls"
cd "..\servers\rls"
set CARGO_HOME=%cd%
cargo install rls
copy bin\rls.exe .
rd /S /Q "bin"
rd /S /Q "registry"
del .package-cache
del .crates.toml
