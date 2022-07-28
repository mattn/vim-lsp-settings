#!/bin/sh

set -e

curl -Lo ./coursier https://git.io/coursier-cli
chmod +x ./coursier

version=$(curl -LsS "https://scalameta.org/metals/latests.json" | grep -o '"release": "[^"]*"' | grep -o '[\.0-9]*')

java_flags=

if [ -n "${https_proxy}" ]; then
  readonly https_proxy_without_protocol="${https_proxy#http://}"
  java_flags="$java_flags -J-Dhttps.proxyHost=${https_proxy_without_protocol%:*}"
  java_flags="$java_flags -J-Dhttps.proxyPort=${https_proxy_without_protocol##*:}"
fi

if [ -n "${http_proxy}" ]; then
  http_proxy_without_protocol="${http_proxy#http://}"
  java_flags="$java_flags -J-Dhttp.proxyHost=${http_proxy_without_protocol%:*}"
  java_flags="$java_flags -J-Dhttp.proxyPort=${http_proxy_without_protocol##*:}"
fi

if [ -n "${no_proxy}" ]; then
  java_flags="$java_flags -J-Dhttp.nonProxyHosts=${no_proxy}"
fi


./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  ${java_flags} \
  org.scalameta:metals_2.13:${version} \
  -r bintray:scalacenter/releases \
  -r sonatype:releases \
  -o metals -f
