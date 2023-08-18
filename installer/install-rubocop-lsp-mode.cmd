@echo off

echo @echo off ^

setlocal ^

set TARGET_DIR=%%1 ^

shift ^

cd %%TARGET_DIR%% ^

bundle exec rubocop %%* ^

> rubocop-lsp-mode.cmd

echo Install Done.
echo **You need add rubocop dependencies in Gemfile.**
