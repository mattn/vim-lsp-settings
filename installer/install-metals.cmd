@echo off

setlocal

curl -Lo coursier https://git.io/coursier-cli
curl -Lo coursier.bat https://git.io/coursier-bat

set VERSION=0.10.4
set JAVA_FLAGS=
if "%HTTPS_PROXY%" neq "" (
  set JAVA_FLAGS=-Dhttps.proxyHost=%HTTPS_PROXY%
)
if "%HTTP_PROXY%" neq "" (
  set JAVA_FLAGS=-Dhttp.proxyHost=%HTTP_PROXY% %JAVA_FLAGS%
)
java %JAVA_FLAGS% -jar coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:%VERSION%" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o metals
