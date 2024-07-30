#!/bin/bash

set -euo pipefail # don't print executed commands to the terminal

# source shared functions
. .buildkite/assets/functions.sh;

echo "BUILDKITE_RETRY_COUNT: $BUILDKITE_RETRY_COUNT"

if [ $BUILDKITE_RETRY_COUNT = 0 ]; then
  echo 'Fail the job with status 1' && exit 1
else
  echo 'Yay, the job retried automatically!'
fi

what_next

