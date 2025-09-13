#!/usr/bin/env bash
set -exuo pipefail

# VERSION must be provided as first argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <VERSION>" >&2
  exit 1
fi
VERSION="$1"

git tag "v${VERSION}"
git push origin "v${VERSION}"
