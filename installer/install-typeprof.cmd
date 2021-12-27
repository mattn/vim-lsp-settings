@echo off

git clone --depth=1 https://github.com/ruby/typeprof .

call bundle install --without development --path vendor/bundle

echo @echo off ^

setlocal ^

set BUNDLE_GEMFILE=%%~dp0Gemfile ^

bundle exec ruby %%~dp0\exe\typeprof %%* ^

> typeprof.cmd

