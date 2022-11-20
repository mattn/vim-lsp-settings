#!/bin/sh

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
  platform="linux"
  ;;
darwin)
  platform="macos"
  ;;
esac

case $(uname -m) in
  arm64)
    arch=arm64
    ;;
  aarch64)
    arch=arm64
    ;;
  *)
    arch=x64
    ;;
esac

filename="dartsdk-$platform-$arch-release.zip"

curl -o "$filename" "https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-$platform-$arch-release.zip"
unzip "$filename"
rm "$filename"

cat <<EOF >analysis-server-dart-snapshot
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)/dart-sdk
\$DIR/bin/dart language-server \$*
EOF

chmod +x analysis-server-dart-snapshot
