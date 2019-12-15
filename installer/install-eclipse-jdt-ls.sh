#!/bin/bash
@echo off

cd $(dirname $0)
[ -d ../servers/eclipse-jdt-ls ] && rm -rf ../servers/eclipse-jdt-ls
mkdir ../servers/eclipse-jdt-ls
cd ../servers/eclipse-jdt-ls
curl -o jdt-language-server-latest.tar.gz 'http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz'
curl -o lombok.jar 'https://projectlombok.org/downloads/lombok.jar'
tar xvf jdt-language-server-latest.tar.gz
rm jdt-language-server-latest.tar.gz

cat <<EOF > eclipse-jdt-ls
#!/bin/sh

cd \$(dirname \$0)
LAUNCHER=$(ls ./plugins/org.eclipse.equinox.launcher*linux*.jar)
java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -noverify -Xmx1G -javaagent:./lombok.jar -Xbootclasspath/a:./lombok.jar -jar \$LAUNCHER -configuration ./config_linux -data ./data
EOF

chmod +x eclipse-jdt-ls
