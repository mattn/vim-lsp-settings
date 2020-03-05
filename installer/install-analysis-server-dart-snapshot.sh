#!/usr/bin/env bash

set -e

curl -o "dartsdk-linux-x64-release.zip" "https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-linux-x64-release.zip"
unzip "dartsdk-linux-x64-release.zip"
rm "dartsdk-linux-x64-release.zip"

cat <<EOF >analysis-server-dart-snapshot
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/bin/dart \$DIR/bin/snapshots/analysis_server.dart.snapshot --lsp \$*
EOF

chmod +x analysis-server-dart-snapshot
