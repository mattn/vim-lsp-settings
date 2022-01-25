#!/usr/bin/env bash

set -e

git clone --depth=1 -b lsp-test https://github.com/ruby/typeprof .
bundle config set --local path vendor/bundle
bundle config set --local without development
bundle install

cat <<EOF >typeprof
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/exe/typeprof \$*
EOF

chmod +x typeprof
