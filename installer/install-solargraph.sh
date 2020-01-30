#!/usr/bin/env bash

set -e

git clone "https://github.com/castwide/solargraph" .
bundle install --path vendor/bundle

cat <<EOF >solargraph
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
cd \$DIR && bundle exec ruby \$DIR/bin/solargraph stdio
EOF

chmod +x solargraph
