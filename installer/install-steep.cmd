@echo off

git clone --depth=1 https://github.com/soutaro/steep.git .

call bundle config set --local path vendor/bundle
call bundle config set --local without development
call bundle install

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec steep %%* ^

> steep.cmd
