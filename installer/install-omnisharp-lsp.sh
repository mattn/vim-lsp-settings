#!/bin/sh

set -e

version="v1.39.15"

os=$(uname -s | tr "[:upper:]" "[:lower:]")
arch="-x64"
net6=""
dotnet_version=$(dotnet --version)

case $os in
linux) ;;
darwin)
  os="osx"
  arch=""
  ;;
*)
  printf "%s doesn't supported by bash installer" "$os"
  exit 1
  ;;
esac

case $dotnet_version in
*.*)
  mainVersion=${dotnet_version%%.*}
  ;;
*)
  mainVersion=$dotnet_version
  ;;
esac

if [ "$mainVersion" -ge "6" ]; then
  net6="-net6.0"

  if [ "$os" = "osx" ]; then
    if [ "$(uname -m)" = "x86_64" ]; then
      arch="-x64"
    else
      arch="-$(uname -m)"
    fi
  fi

  cat <<EOF >run
#!/bin/sh

base_dir="\$(cd "\$(dirname "\$0")" && pwd -P)"
omnisharp_cmd=\${base_dir}/OmniSharp

"\${omnisharp_cmd}" "\$@"
EOF
fi

url="https://github.com/OmniSharp/omnisharp-roslyn/releases/download/$version/omnisharp-$os$arch$net6.tar.gz"
curl -L "$url" | tar xz

chmod +x run

cat <<EOF >omnisharp-lsp
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
\$DIR/run \$*
EOF

chmod +x omnisharp-lsp
