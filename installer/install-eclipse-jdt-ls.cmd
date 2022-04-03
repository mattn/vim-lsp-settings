@echo off

curl -L "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz" | tar zx
curl -o lombok.jar "https://projectlombok.org/downloads/lombok.jar"

echo @echo off ^

setlocal enabledelayedexpansion ^

for %%%%F in (%%~dp0\plugins\org.eclipse.equinox.launcher_*.jar) do ( ^

  set launcher=%%%%F ^

) ^

java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -noverify -Xmx1G -javaagent:%%~dp0/lombok.jar -Xbootclasspath/a:%%~dp0/lombok.jar -jar !launcher! -configuration %%~dp0\config_win -data %%~dp0\data ^

> eclipse-jdt-ls.cmd

