@echo off

call "%~dp0\npm_install.cmd" svelteserver svelte-language-server
ren svelteserver.cmd svelte-language-server.cmd
