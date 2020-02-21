@echo off

git clone "https://github.com/castwide/solargraph" .

call bundle install --path vendor/bundle

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec ruby %%~dp0\bin\solargraph %%* ^

> solargraph.cmd

