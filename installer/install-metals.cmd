@echo off

setlocal

curl -Lo coursier https://git.io/coursier-cli
curl -Lo coursier.bat https://git.io/coursier-bat

set VERSION=0.8.4
java %JAVA_OPTS% -jar coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:%VERSION%" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o metals
