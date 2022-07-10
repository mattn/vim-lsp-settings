#!/bin/sh

set -e

git clone --depth=1 https://github.com/prominic/groovy-language-server .
./gradlew build

cat <<EOF >groovy-language-server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/build/libs/groovy-language-server-all.jar \$*
EOF

chmod +x groovy-language-server
