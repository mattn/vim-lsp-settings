#!/usr/bin/env bash
set -o errexit

git clone --depth=1 https://github.com/puppetlabs/puppet-editor-services.git .
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec rake gem_revendor

cat <<'EOF' >puppet-ls
#!/usr/bin/env bash
set -o errexit
cd "$(dirname "$0")"
exec bundle exec ruby ./puppet-languageserver "$@"
EOF

chmod +x puppet-ls
