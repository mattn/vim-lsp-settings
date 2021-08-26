#!/usr/bin/env bash

set -e

git clone --depth=1 https://github.com/soutaro/steep.git .
bundle install --without development --path vendor/bundle

cat <<EOF >steep
#!/usr/bin/env bash

DIR=\$(cd \$(dirname \$0); pwd)
BUNDLE_GEMFILE=\$DIR/Gemfile bundle exec steep \$*
EOF

chmod +x steep
