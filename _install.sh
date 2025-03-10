#!/bin/bash
set -xeuo pipefail

ref=$1

rm -rf .codeguide && mkdir -p .codeguide
curl -L https://github.com/hotdog-werx/codeguide/archive/refs/heads/$ref.zip | bsdtar -xvf- -C .codeguide

destDir=.codeguide
rootDir=.codeguide/codeguide-$ref

mkdir -p "$destDir"
mv "$rootDir/config" $destDir/config
mv "$rootDir/tasks" $destDir/tasks

rm -rf "$rootDir"
echo "codeguide@$ref" > "$destDir/VERSION"
echo "codeguide@$ref downloaded to $destDir"
