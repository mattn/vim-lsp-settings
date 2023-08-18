#!/bin/sh

set -e

cat <<EOF >rubocop-lsp-mode
#!/bin/sh

TARGET_DIR=\$1
shift
cd \${TARGET_DIR}
bundle exec rubocop \$*
EOF

chmod +x rubocop-lsp-mode

echo 'Install Done.'
echo '**You need add rubocop dependencies in Gemfile.**'
