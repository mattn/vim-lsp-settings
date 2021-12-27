#!/usr/bin/env bash

set -e

git clone --depth=1 -b lsp-test https://github.com/ruby/typeprof .
bundle install --without development --path vendor/bundle

cat <<EOF >typeprof
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/exe/typeprof \$*
EOF

chmod +x typeprof
