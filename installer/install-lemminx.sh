#!/usr/bin/env bash

set -e

# See https://repo.eclipse.org/content/repositories/lemminx-snapshots/org/eclipse/org.eclipse.lemminx/
version="0.11.0"
url="https://repo.eclipse.org/content/repositories/lemminx-snapshots/org/eclipse/org.eclipse.lemminx/0.11.0-SNAPSHOT/org.eclipse.lemminx-0.11.0-20200309.180941-1-uber.jar"

curl -L "$url" -o "org.eclipse.lemminx-${version}-uber.jar"

cat <<EOF >lemminx
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/org.eclipse.lemminx-${version}-uber.jar
EOF

chmod +x lemminx
