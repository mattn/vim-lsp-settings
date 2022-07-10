#!/bin/sh

set -e

git clone --depth=1 https://github.com/kwerle/ruby_language_server .
bundle config set --local path vendor/bundle
bundle config set --local without development
bundle install

cat <<EOF >ruby_language_server
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/exe/ruby_language_server \$*
EOF

chmod +x ruby_language_server
