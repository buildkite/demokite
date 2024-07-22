#!/bin/bash

# set explanation: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
# set -euxo pipefail # print executed commands to the terminal
set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

# capture original working directory
current_dir=$(pwd)
current_dir_contents=$(ls -lah $current_dir)

# change into steps/parallel-steps/ directory
cd .buildkite/steps/parallel-steps/;

RANDOM_DURATION=$(shuf -i 5-20 -n 1)
echo -e "\033[1;35mThis is parallel job $((BUILDKITE_PARALLEL_JOB+1)) of $BUILDKITE_PARALLEL_JOB_COUNT and has been randomly set to run for $RANDOM_DURATION seconds.\033[0m"
sleep $RANDOM_DURATION
