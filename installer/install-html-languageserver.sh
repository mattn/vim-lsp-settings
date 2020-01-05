#!/bin/bash

set -e

cd $(dirname $0)

git clone --depth=1 https://github.com/vscode-langservers/vscode-html-languageserver ../servers/html-languageserver
cd ../servers/html-languageserver
npm install
npm install --save typescript
cat << EOF > tsconfig.json
{
	"compilerOptions": {
		"target": "es2018",
		"module": "commonjs",
		"strict": true,
		"alwaysStrict": true,
		"noImplicitAny": true,
		"noImplicitReturns": true,
		"noUnusedLocals": true,
		"noUnusedParameters": true,
		"outDir": "./out"
	},
	"include": [
		"src/**/*"
	]
}
EOF
./node_modules/typescript/bin/tsc -p .
cat << EOF > html-languageserver
#!/usr/bin/env node
require('./out/htmlServerMain.js')
EOF
chmod +x html-languageserver
