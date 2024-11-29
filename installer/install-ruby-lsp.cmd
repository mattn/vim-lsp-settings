@echo off

git clone --depth=1 https://github.com/Shopify/ruby-lsp .
call bundle config set --local path vendor/bundle
call bundle config set --local without development
call bundle install

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec ruby %%~dp0\exe\ruby-lsp %%* ^

> ruby-lsp.cmd

