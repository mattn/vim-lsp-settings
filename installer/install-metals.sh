#!/usr/bin/env bash

set -e

curl -Lo ./coursier https://git.io/coursier-cli
chmod +x ./coursier

version="0.10.4"
java_flags=()

if [[ -n "${https_proxy}" ]]; then
  readonly https_proxy_without_protocol="${https_proxy#http://}"
  java_flags+=("-Dhttps.proxyHost=${https_proxy_without_protocol%:*}")
  java_flags+=("-Dhttps.proxyPort=${https_proxy_without_protocol##*:}")
fi

if [[ -n "${http_proxy}" ]]; then
  http_proxy_without_protocol="${http_proxy#http://}"
  java_flags+=("-Dhttp.proxyHost=${http_proxy_without_protocol%:*}")
  java_flags+=("-Dhttp.proxyPort=${http_proxy_without_protocol##*:}")
fi

if [[ -n "${no_proxy}" ]]; then
  java_flags+=("-Dhttp.nonProxyHosts=${no_proxy}")
fi

java "${java_flags[@]}" -jar ./coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:${version}" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o ./metals
