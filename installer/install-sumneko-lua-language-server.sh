#!/usr/bin/env bash

set -e

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux)
	platform="Linux"
	;;
darwin)
	platform="macOS"
	;;
esac

version="0.20.2"

publisher="sumneko"
extensionname="lua"
filename="sumneko-lua-language-server.zip"

curl -Lo "$filename" "https://$publisher.gallery.vsassets.io/_apis/public/gallery/publisher/$publisher/extension/$extensionname/$version/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
unzip "$filename"
rm "$filename"

chmod +x extension/server/bin/$platform/lua-language-server

cat <<EOF >sumneko-lua-language-server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)/extension/server
\$DIR/bin/$platform/lua-language-server -E -e LANG=en \$DIR/main.lua \$*
EOF

chmod +x sumneko-lua-language-server
