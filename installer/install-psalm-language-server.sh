#!/usr/bin/env bash

set -e

composer require vimeo/psalm
ln -s "./vendor/bin/psalm-language-server" .
