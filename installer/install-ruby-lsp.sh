#!/bin/sh

set -e

git clone --depth=1 https://github.com/Shopify/ruby-lsp .
bundle config set --local path vendor/bundle
bundle config set --local without development
bundle install

cat <<EOF >ruby-lsp
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec ruby \$DIR/exe/ruby-lsp \$*
EOF

chmod +x ruby-lsp
