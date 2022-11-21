@echo off

git clone --depth=1 https://github.com/kwerle/ruby_language_server .

call bundle config set --local path vendor/bundle
call bundle config set --local without development
call bundle install

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec ruby %%~dp0\exe\ruby_language_server %%* ^

> ruby_language_server.cmd

