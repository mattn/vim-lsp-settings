@echo off

setlocal

cd %~dp0

set server_dir="..\servers\metals"
rd /Q /S %server_dir%
md %server_dir%
cd "%server_dir%"

curl -Lo coursier https://git.io/coursier-cli
curl -Lo coursier.bat https://git.io/coursier-bat

set version="0.7.6"
java %JAVA_OPTS% -jar coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:%version%" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o metals
