#!/bin/sh

set -e

"$(dirname "$0")/go_install.sh" github.com/mattn/efm-langserver@latest &&
CONFIG="$HOME/.config/efm-langserver/config.yaml" &&
if ! [ -e "$CONFIG" ]; then
    mkdir -p "$(dirname "$CONFIG")" &&
    {
    # config copied from:
    # https://github.com/mattn/efm-langserver/blob/c7ef2b16238a9561893daa0121769ca37f258356/README.md
    cat <<EFM_CONFIG >"$CONFIG"
version: 2
root-markers:
  - .git/
lint-debounce: 1s
commands:
  - command: notepad
    arguments:
      - ${INPUT}
    title: メモ帳

tools:
  any-excitetranslate: &any-excitetranslate
    hover-command: 'excitetranslate'
    hover-stdin: true

  blade-blade-formatter: &blade-blade-formatter
    format-command: 'blade-formatter --stdin'
    format-stdin: true

  css-prettier: &css-prettier
    format-command: './node_modules/.bin/prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser css'

  csv-csvlint: &csv-csvlint
    lint-command: 'csvlint'

  dockerfile-hadolint: &dockerfile-hadolint
    lint-command: 'hadolint'
    lint-formats:
      - '%f:%l %m'

  eruby-erb: &eruby-erb
    lint-debounce: 2s
    lint-command: 'erb -x -T - | ruby -c'
    lint-stdin: true
    lint-offset: 1
    format-stdin: true
    format-command: htmlbeautifier

  html-prettier: &html-prettier
    format-command: './node_modules/.bin/prettier ${--tab-width:tabWidth} ${--single-quote:singleQuote} --parser html'

  javascript-eslint: &javascript-eslint
    lint-command: 'eslint -f visualstudio --stdin --stdin-filename ${INPUT}'
    lint-ignore-exit-code: true
    lint-stdin: true
    lint-formats:
      - "%f(%l,%c): %tarning %m"
      - "%f(%l,%c): %rror %m"

  json-fixjson: &json-fixjson
    format-command: 'fixjson'

  json-jq: &json-jq
    lint-command: 'jq .'

  json-prettier: &json-prettier
    format-command: './node_modules/.bin/prettier ${--tab-width:tabWidth} --parser json'

  lua-lua-format: &lua-lua-format
    format-command: 'lua-format -i'
    format-stdin: true

  make-checkmake: &make-checkmake
    lint-command: 'checkmake'
    lint-stdin: true

  markdown-markdownlint: &markdown-markdownlint
    lint-command: 'markdownlint -s -c %USERPROFILE%\.markdownlintrc'
    lint-stdin: true
    lint-formats:
      - '%f:%l %m'
      - '%f:%l:%c %m'
      - '%f: %l: %m'

  markdown-pandoc: &markdown-pandoc
    format-command: 'pandoc -f markdown -t gfm -sp --tab-stop=2'

  mix_credo: &mix_credo
    lint-command: "mix credo suggest --format=flycheck --read-from-stdin ${INPUT}"
    lint-stdin: true
    lint-formats:
      - '%f:%l:%c: %t: %m'
      - '%f:%l: %t: %m'
    root-markers:
      - mix.lock
      - mix.exs

  php-phpstan: &php-phpstan
    lint-command: './vendor/bin/phpstan analyze --error-format raw --no-progress'

  php-psalm: &php-psalm
    lint-command: './vendor/bin/psalm --output-format=emacs --no-progress'
    lint-formats:
      - '%f:%l:%c:%trror - %m'
      - '%f:%l:%c:%tarning - %m'

  python-autopep8: &python-autopep8
    format-command: 'autopep8 -'
    format-stdin: true

  python-black: &python-black
    format-command: 'black --quiet -'
    format-stdin: true

  python-flake8: &python-flake8
    lint-command: 'flake8 --stdin-display-name ${INPUT} -'
    lint-stdin: true
    lint-formats:
      - '%f:%l:%c: %m'

  python-isort: &python-isort
    format-command: 'isort --quiet -'
    format-stdin: true

  python-mypy: &python-mypy
    lint-command: 'mypy --show-column-numbers'
    lint-formats:
      - '%f:%l:%c: %trror: %m'
      - '%f:%l:%c: %tarning: %m'
      - '%f:%l:%c: %tote: %m'

  python-pylint: &python-pylint
    lint-command: 'pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}'
    lint-stdin: false
    lint-formats:
      - '%f:%l:%c:%t:%m'
    lint-offset-columns: 1
    lint-category-map:
      I: H
      R: I
      C: I
      W: W
      E: E
      F: E

  python-yapf: &python-yapf
    format-command: 'yapf --quiet'
    format-stdin: true

  rst-lint: &rst-lint
    lint-command: 'rst-lint'
    lint-formats:
      - '%tNFO %f:%l %m'
      - '%tARNING %f:%l %m'
      - '%tRROR %f:%l %m'
      - '%tEVERE %f:%l %m'

  rst-pandoc: &rst-pandoc
    format-command: 'pandoc -f rst -t rst -s --columns=79'

  sh-shellcheck: &sh-shellcheck
    lint-command: 'shellcheck -f gcc -x'
    lint-source: 'shellcheck'
    lint-formats:
      - '%f:%l:%c: %trror: %m'
      - '%f:%l:%c: %tarning: %m'
      - '%f:%l:%c: %tote: %m'

  sh-shfmt: &sh-shfmt
    format-command: 'shfmt -ci -s -bn'
    format-stdin: true

  vim-vint: &vim-vint
    lint-command: 'vint -'
    lint-stdin: true
    lint-formats:
      - '%f:%l:%c: %m'

  yaml-yamllint: &yaml-yamllint
    lint-command: 'yamllint -f parsable -'
    lint-stdin: true

languages:
  blade:
    - <<: *blade-blade-formatter

  css:
    - <<: *css-prettier

  csv:
    - <<: *csv-csvlint

  dockerfile:
    - <<: *dockerfile-hadolint

  elixir:
    - <<: *mix_credo

  eruby:
    - <<: *eruby-erb

  html:
    - <<: *html-prettier

  javascript:
    - <<: *javascript-eslint

  json:
    - <<: *json-fixjson
    - <<: *json-jq
    # - <<: *json-prettier

  lua:
    - <<: *lua-lua-format

  make:
    - <<: *make-checkmake

  markdown:
    - <<: *markdown-markdownlint
    - <<: *markdown-pandoc

  php:
    - <<: *php-phpstan
    - <<: *php-psalm

  python:
    - <<: *python-black
    - <<: *python-flake8
    - <<: *python-isort
    - <<: *python-mypy
    # - <<: *python-autopep8
    # - <<: *python-yapf

  rst:
    - <<: *rst-lint
    - <<: *rst-pandoc

  sh:
    - <<: *sh-shellcheck
    - <<: *sh-shfmt

  vim:
    - <<: *vim-vint

  yaml:
    - <<: *yaml-yamllint

  =:
    - <<: *any-excitetranslate
EFM_CONFIG
    }
fi
