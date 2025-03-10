#!/bin/bash
set -xeuo pipefail

testPattern=${PATTERN:-''}
includeFiles=${INCLUDE:-''}
coverageFailUnder=${COVERAGE_FAIL_UNDER:-100}
pythonDir=${PYTHON_DIR:-'packages/python'}

if [ "${CI:-false}" = 'true' ]; then
    testPattern=''
fi

modules=("$PYTHON_MODULE")

sources=''
for module in "${modules[@]}"; do
    if [ -z "$sources" ]; then
        sources="$pythonDir/$module"
    else
        sources="$sources,$pythonDir/$module"
    fi
done

if [ -z "$testPattern" ]; then
    uv run coverage run \
        --concurrency 'thread,greenlet' \
        --source "$sources" -m pytest -vv "$pythonDir"
    uv run coverage report -m --fail-under "$coverageFailUnder"
else
    coverageArguments=(--concurrency 'thread,greenlet')
    if [ -z "$includeFiles" ]; then
        coverageArguments+=(--source "$sources")
    else
        coverageArguments+=(--include "$includeFiles")
    fi
    coverageArguments+=(-m pytest "$pythonDir" -vv -s -k "$testPattern")

    uv run coverage run "${coverageArguments[@]}"
    uv run coverage report
fi
