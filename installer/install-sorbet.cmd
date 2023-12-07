@echo off

echo @echo off ^

setlocal ^

set TARGET_DIR=%%1 ^

shift ^

cd %%TARGET_DIR%% ^

bundle exec srb typecheck %%* ^

> sorbet.cmd

echo Install Done.
echo **You need add sorbet dependencies in Gemfile.**
