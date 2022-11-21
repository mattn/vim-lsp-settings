@echo off
setlocal

for /f "delims=" %%i in ('dotnet --version') do set version=%%i


set mainVersion=%version:.=&rem %

if /i "%mainVersion%" geq "6" (
	curl -L -o omnisharp.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-win-x64-net6.0.zip"
) else (
	curl -L -o omnisharp.zip "https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-win-x64.zip"
)

call "%~dp0\run_unzip.cmd" omnisharp.zip
del omnisharp.zip

echo @echo off ^

%%~dp0\omnisharp.exe %%* ^

> omnisharp-lsp.cmd
