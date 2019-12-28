#!/bin/bash

set -e

cd $(dirname $0)

server_dir="../servers/omnisharp-lsp"
[ -d $server_dir ] && rm -rf $server_dir
mkdir $server_dir && cd $server_dir

os=$(uname -s | tr "[:upper:]" "[:lower:]")

case $os in
linux) ;;
darwin)
  os="osx"
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

version="v1.34.9"
url="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/$version/omnisharp-$os-x64.tar.gz"
curl -LO "$url"
tar xzvf omnisharp-$os-x64.tar.gz
rm omnisharp-$os-x64.tar.gz

chmod +x run

cat <<EOF > omnisharp-lsp
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/run \$*
EOF

chmod +x omnisharp-lsp
