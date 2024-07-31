#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euxo pipefail # print executed commands to the terminal
# set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# upload behind the scenes annotation
behind_the_scenes_annotation "annotations"

# change into steps/annotations/ directory
cd .buildkite/steps/annotations/;

# replace variables in annotation file
FILE_PATH="./assets/example01.md"

replace_file_var $FILE_PATH "\$BUILDKITE_BUILD_URL" "$BUILDKITE_BUILD_URL"
replace_file_var $FILE_PATH "\$BUILDKITE_JOB_ID" "$BUILDKITE_JOB_ID"
replace_file_var $FILE_PATH "\$BUILDKITE_LABEL" "$BUILDKITE_LABEL"

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

