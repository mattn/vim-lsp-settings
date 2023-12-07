#!/bin/sh

set -e

cat <<EOF >sorbet
#!/bin/sh

TARGET_DIR=\$1
shift
cd \${TARGET_DIR}
bundle exec srb typecheck \$*
EOF

chmod +x sorbet

echo 'Install Done.'
echo '**You need add sorbet dependencies in Gemfile.**'
