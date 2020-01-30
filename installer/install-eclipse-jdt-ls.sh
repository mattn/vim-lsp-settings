#!/usr/bin/env bash

set -e

curl -o jdt-language-server-latest.tar.gz 'http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz'
curl -o lombok.jar 'https://projectlombok.org/downloads/lombok.jar'
tar xvf jdt-language-server-latest.tar.gz
rm jdt-language-server-latest.tar.gz

cat <<EOF > eclipse-jdt-ls
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
LAUNCHER=\$(ls \$DIR/plugins/org.eclipse.equinox.launcher_*.jar)
java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -noverify -Xmx1G -javaagent:\$DIR/lombok.jar -Xbootclasspath/a:\$DIR/lombok.jar -jar \$LAUNCHER -configuration \$DIR/config_linux -data \$DIR/data
EOF

chmod +x eclipse-jdt-ls
