#!/bin/bash

set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# upload behind the scenes annotation
behind_the_scenes_annotation "annotations"

# change into steps/annotations/ directory
cd .buildkite/steps/annotations/;

# annotation file
FILE_PATH="./assets/example01.md"

# annotate
buildkite-agent annotate 'Example `error` style annotation' --style 'error' --context 'ctx-error'
buildkite-agent annotate 'Example `warning` style annotation' --style 'warning' --context 'ctx-warning'
buildkite-agent annotate 'Example `default` style annotation' --context 'ctx-default'
buildkite-agent annotate 'Example `info` style annotation' --style 'info' --context 'ctx-info'

printf '%b\n' "$(cat $FILE_PATH)" | buildkite-agent annotate --style 'success' --context 'example'

# upload assets as artifacts
buildkite-agent artifact upload "assets/*" --log-level error;

buildkite-agent meta-data set "annotations" "static"

# return to root directory
cd ../../..;

what_next

