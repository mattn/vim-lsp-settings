@echo off

if not exist package.json (
	call npm init -y

	echo {"name":""}>package.json
)

call npm install "graphql"
call npm install "graphql-language-service-cli"

echo @echo off ^

call %%~dp0\node_modules\.bin\graphql-lsp %%* ^

> graphql-language-server.cmd
