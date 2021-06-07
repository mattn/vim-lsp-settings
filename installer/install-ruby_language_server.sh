#!/usr/bin/env bash

set -e

git clone --depth=1 https://github.com/kwerle/ruby_language_server .
bundle install --without development --path vendor/bundle

cat <<EOF >ruby_language_server
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/exe/ruby_language_server \$*
EOF

chmod +x ruby_language_server
