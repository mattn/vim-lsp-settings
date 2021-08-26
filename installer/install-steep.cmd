@echo off

git clone --depth=1 https://github.com/soutaro/steep.git .

call bundle install --without development --path vendor/bundle

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec steep %%* ^

> steep.cmd
