#!/bin/bash
set -xeuo pipefail

ref=$(echo "$1" | sed 's/\//-/g')

rm -rf .codeguide && mkdir -p .codeguide
curl -L https://github.com/hotdog-werx/codeguide/archive/refs/heads/$1.zip | bsdtar -xvf- -C .codeguide

destDir=.codeguide
rootDir=.codeguide/codeguide-$ref

mkdir -p "$destDir"
mv "$rootDir/config" $destDir/config
mv "$rootDir/tasks" $destDir/tasks
chmod +x "$destDir/tasks/"*.sh

rm -rf "$rootDir"
echo "codeguide@$ref" > "$destDir/VERSION"
echo "codeguide@$ref downloaded to $destDir"
