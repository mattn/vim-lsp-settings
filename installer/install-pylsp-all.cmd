@echo off

call "%~dp0\pip_install.cmd" pylsp "python-lsp-server[all]"
move pylsp.cmd pylsp-all.cmd
