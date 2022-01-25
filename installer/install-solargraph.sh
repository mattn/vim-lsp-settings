#!/usr/bin/env bash

set -e

git clone --depth=1 https://github.com/castwide/solargraph .
bundle config set --local path vendor/bundle
bundle config set --local without development
bundle install

cat <<EOF >solargraph
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/bin/solargraph \$*
EOF

chmod +x solargraph
