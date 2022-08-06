#!/bin/sh

set -e

version="0.14.1"
url="https://repo.eclipse.org/content/repositories/lemminx-releases/org/eclipse/lemminx/org.eclipse.lemminx/${version}/org.eclipse.lemminx-${version}-uber.jar"
lemminx_jar="org.eclipse.lemminx-${version}-uber.jar"

curl -L "$url" -o "${lemminx_jar}"

cat <<EOF >lemminx
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
java -jar \$DIR/${lemminx_jar}
EOF

chmod +x lemminx
