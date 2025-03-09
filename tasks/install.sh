#!/bin/bash
set -xeuo pipefail

if [[ ! -f 'uv.lock' ]]; then
    uv lock
fi

installOptions=${UV_INSTALL_OPTS:='--group dev --all-extras --locked'}
uv sync $installOptions
