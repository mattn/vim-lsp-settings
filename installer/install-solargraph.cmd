@echo off

git clone "https://github.com/castwide/solargraph" .

call bundle install --path vendor/bundle

echo @echo off ^

bundle exec ruby %%~dp0\bin/solargraph stdio ^

> solargraph.cmd

