#!/bin/sh

set -e

cd $(dirname $0)
[ -d ../servers/solargraph ] && rm -rf ../servers/solargraph
mkdir ../servers/solargraph
cd ../servers/solargraph
git clone "https://github.com/castwide/solargraph" .
bundle install --path vendor/bundle

cat <<EOF > solargraph
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
cd \$DIR && bundle exec ruby \$DIR/bin/solargraph stdio
EOF

chmod +x solargraph
