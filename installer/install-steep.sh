#!/bin/sh

set -e

git clone --depth=1 https://github.com/soutaro/steep.git .
bundle config set --local path vendor/bundle
bundle config set --local without development
bundle install

cat <<EOF >steep
#!/bin/sh

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec steep \$*
EOF

chmod +x steep
