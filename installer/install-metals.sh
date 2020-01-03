#!/bin/bash

set -e

curl -Lo ./coursier https://git.io/coursier-cli
chmod +x ./coursier

version="0.7.6"
java -jar ./coursier bootstrap --ttl Inf "org.scalameta:metals_2.12:$version" -r "bintray:scalacenter/releases" -r "sonatype:public" -r "sonatype:snapshots" -o ./metals
