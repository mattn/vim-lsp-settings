@echo off

git clone --depth=1 https://github.com/vscode-langservers/vscode-json-languageserver ./

echo {^

	"compilerOptions": {^

		"target": "es2018",^

		"module": "commonjs",^

		"strict": true,^

		"alwaysStrict": true,^

		"noImplicitAny": true,^

		"noImplicitReturns": true,^

		"noUnusedLocals": true,^

		"noUnusedParameters": true,^

		"outDir": "./out",^

		"sourceMap": true,^

		"sourceRoot": "../src"^

	},^

	"include": [^

		"src/**/*"^

	]^

}^

> tsconfig.json

call npm i
call npx tsc -p .

echo @echo off ^

node %%~dp0\out\jsonServerMain.js %%* ^

> json-languageserver.cmd
